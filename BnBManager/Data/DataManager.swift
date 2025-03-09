//
//  DataManager.swift
//  BnBManager
//
//  Created by Nicola Chiarappa on 07/03/25.
//

import Foundation
import CoreData

@Observable
class DataManager: NSObject{
    
    static let shared = DataManager()
    static func resetDatabase(persistentContainer: NSPersistentContainer) {
        let context = persistentContainer.viewContext
        let entities = persistentContainer.managedObjectModel.entities
        
        for entity in entities {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name!)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                print("Errore nel reset del database: \(error)")
            }
        }
    }
    
    
    
    var roomsDict : [UUID:Room] = [:]
    
    var rooms: [Room] {Array(roomsDict.values)}
    let context: NSManagedObjectContext
    let roomFRC: NSFetchedResultsController<RoomModel>
    let container:NSPersistentContainer
    
    
    
    override init(){
        
        let store = PersistentStore()
        container = store.container
        context = store.context
        let roomFR = RoomModel.fetchRequest()
        roomFR.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        roomFRC = NSFetchedResultsController(fetchRequest: roomFR, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        
        super.init()
        
        roomFRC.delegate = self
        fetchRooms()
    }
    
    
    
    func saveData() {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                NSLog("Unresolved error saving context: \(error), \(error.userInfo)")
            }
        }
    }
    
    func fetchRooms(){
        try? roomFRC.performFetch()
        
        if let newRooms = roomFRC.fetchedObjects{
            self.roomsDict = Dictionary(uniqueKeysWithValues: newRooms.map{
                ($0.id!, Room(roomMO: $0))
            })
        }
    }
}






extension DataManager : NSFetchedResultsControllerDelegate{
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        if let newRooms = controller.fetchedObjects as? [RoomModel]{
            self.roomsDict = Dictionary(uniqueKeysWithValues: newRooms.map{
                ($0.id!, Room(roomMO: $0))
            })
        }
    }
    
    
    
    func fetchFirst<T:NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate)->Result<T?, Error>{
        
        let request = objectType.fetchRequest()
        request.predicate = predicate
        
        do{
            let result = try context.fetch(request) as? [T]
            
            return .success(result?.first)
            
        }catch{
            return .failure(error)
        }
        
    }
    
    
    
    
    
    // MARK: -Room methods
    
    ///update RoomModel using a Room object data
    private func update(roomModel: RoomModel, room: Room){
        roomModel.area = Int16(room.area)
        roomModel.id = room.id
        roomModel.name = room.name
        roomModel.maxBeds = Int16(room.maxBeds)
        roomModel.minBeds = Int16(room.minBeds)
        roomModel.valuation = room.valuation
    }
    
    ///Fetch a RoomModel based on its id
    ///If not exists create it
    ///Update an existing RoomMode
    func updateAndSave(room:Room){
        let fetchedRoom = fetchFirst(RoomModel.self, predicate: NSPredicate(format: "id = %@", room.id as CVarArg))
        
        switch fetchedRoom{
        case .success(let foundRoom):
            if let roomMo = foundRoom{
                update(roomModel: roomMo, room: room)
            }else{
                roomMO(from: room)
            }
        case .failure(_):
            print("errore")
            
        }
        saveData()
    }
    
    
    ///Create new RoomModel from a Room object
    private func roomMO(from room: Room){
        let roomModel = RoomModel(context: self.context)
        roomModel.id = room.id
        update(roomModel: roomModel, room: room)
    }
    
    
    ///Delete a RoomModel from store
    func delete(room:Room){
        let fetchedRoom = fetchFirst(RoomModel.self, predicate: NSPredicate(format: "id = %@", room.id as CVarArg))
        
        switch fetchedRoom{
        case .success(let foundRoom):
            if let roomMo = foundRoom{
                context.delete(roomMo)
            }
            saveData()
            
        default: return
        }
        
    }
    
}




extension Room{
    init(roomMO: RoomModel){
        self.id = roomMO.id ?? UUID()
        self.name = roomMO.name ?? ""
        self.area = Int(roomMO.area)
        self.minBeds = Int(roomMO.minBeds)
        self.maxBeds = Int(roomMO.maxBeds)
        self.amenities = []
        self.valuation = roomMO.valuation
    }
    
    
}
