//
//  DataManager.swift
//  BnBManager
//
//  Created by Nicola Chiarappa on 07/03/25.
//

import Foundation
import CoreData

@Observable class DataManager{
    
    var rooms: [Room] = []
    let context: NSManagedObjectContext
    
    init(){
        let container = PersistentStore()
        context = container.context
        
        let roomFR: NSFetchRequest = RoomMO.fetchRequest()
        roomFR.sortDescriptors =  [NSSortDescriptor(key: "name", ascending: false)]
        let roomsFRC: NSFetchedResultsController = NSFetchedResultsController(fetchRequest: roomFR, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
        
        try? roomsFRC.performFetch()
        
        if let newRooms = roomsFRC.fetchedObjects{
            
            for newRoom in newRooms{
                self.rooms.append(Room(roomMO: newRoom))
            }
        }
        
        
        
        
        
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
    
    func manyRooms(){
        for i in 0...7{
            let roomMO = RoomMO(context: context)
            roomMO.maxBeds = 10
            roomMO.minBeds = 2
            roomMO.name = i.description
            roomMO.area = 15
            roomMO.valuation = 4
            roomMO.id = UUID(uuidString: i.description+roomMO.maxBeds.description)
            self.saveData()
        }
    }
    
    
    
}


extension Room{
    init(roomMO: RoomMO){
        self.name = roomMO.name ?? ""
        self.area = Int(roomMO.area)
        self.minBeds = Int(roomMO.minBeds)
        self.maxBeds = Int(roomMO.maxBeds)
        self.amenities = []
        self.valuation = roomMO.valuation
    }
    
    
}
