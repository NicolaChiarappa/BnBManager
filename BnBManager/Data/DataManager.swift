//
//  DataManager.swift
//  BnBManager
//
//  Created by Nicola Chiarappa on 07/03/25.
//

import Foundation
import CoreData

@Observable class DataManager{
    
    var roomsDict : [UUID:Room] = [:]
    
    var rooms: [Room] = []
    let context: NSManagedObjectContext
    
    init(){
        let container = PersistentStore()
        context = container.context
        fetchRoom()
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
    
    func deleteAllData() {
        guard let persistentStoreCoordinator = context.persistentStoreCoordinator else { return }
        
        for store in persistentStoreCoordinator.persistentStores {
            do {
                try persistentStoreCoordinator.destroyPersistentStore(at: store.url!, ofType: store.type, options: nil)
            } catch {
                print("Errore durante l'eliminazione del database: \(error)")
            }
        }
    }
    
    
    func fetchRoom(predicate: NSPredicate? = nil){
        let roomFR: NSFetchRequest = RoomModel.fetchRequest()
        roomFR.sortDescriptors =  [NSSortDescriptor(key: "name", ascending: false)]
        
        if let predicate = predicate{
            roomFR.predicate = predicate
        }
        
        let roomsFRC: NSFetchedResultsController = NSFetchedResultsController(fetchRequest: roomFR, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
        
        try? roomsFRC.performFetch()
        
        if let newRooms = roomsFRC.fetchedObjects{
            for newRoom in newRooms{
                self.rooms.append(Room(roomMO: newRoom))
            }
        }
    }
    
    
    
    
    func fetchFirst<T:NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate)->Result<T?, Error>{
        
        let request = objectType.fetchRequest()
        request.predicate = predicate
        
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
        
        do{
            let result = try context.fetch(request) as? [T]
            
            return .success(result?.first)
            
        }catch{
            return .failure(error)
        }
        
    }
    
    
    
    
    
// MARK: -Room methods
    
    func update(roomModel: RoomModel, room: Room){
        roomModel.area = Int16(room.area)
        roomModel.id = room.ID
        roomModel.name = room.name
        roomModel.maxBeds = Int16(room.maxBeds)
        roomModel.minBeds = Int16(room.minBeds)
        roomModel.valuation = room.valuation
    }
    
    
    func updateAndSave(room:Room){
        
        
        
        
    }
    
    
    
    
    
}


extension Room{
    init(roomMO: RoomModel){
        self.name = roomMO.name ?? ""
        self.area = Int(roomMO.area)
        self.minBeds = Int(roomMO.minBeds)
        self.maxBeds = Int(roomMO.maxBeds)
        self.amenities = []
        self.valuation = roomMO.valuation
    }
    
    
}
