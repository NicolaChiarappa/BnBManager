//
//  SettingsViewModel.swift
//  BnBManager
//
//  Created by Nicola Chiarappa on 08/03/25.
//

import Foundation
import SwiftUI

@Observable
class SettingsViewModel{
    
    
    var dataManager=DataManager.shared
    
    
    
    func fetch(){
        dataManager.fetchRooms()
    }
    
    
    
    
    func edit(name:String, roomID: UUID){
        dataManager.roomsDict[roomID]?.name=name
        dataManager.updateAndSave(room: dataManager.roomsDict[roomID]!)
    }
    
    
    func delete(roomIndexes: IndexSet){
        for index in roomIndexes{
            let roomPos = index
            let myRoom = dataManager.rooms[roomPos]
            dataManager.delete(room: myRoom)
            
        }
        
        
        
        
    }
    
}
