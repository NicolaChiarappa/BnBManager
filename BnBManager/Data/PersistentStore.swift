//
//  CoreData.swift
//  BnBManager
//
//  Created by Nicola Chiarappa on 28/02/25.
//

import CoreData

struct PersistentStore{
    let container : NSPersistentContainer
    init(inMemory:Bool = false){
        container = NSPersistentContainer(name: "CoreDataModel")
        if (inMemory){
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath:"/dev/null")
        }
        
        container.viewContext.automaticallyMergesChangesFromParent=true
        
    }
}
