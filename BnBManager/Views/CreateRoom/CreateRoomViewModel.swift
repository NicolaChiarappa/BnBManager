//
//  CreateRoomViewModel.swift
//  BnBManager
//
//  Created by Nicola Chiarappa on 11/02/25.
//
import SwiftUI

@Observable
class CreateRoomViewModel:ObservableObject{
    var amenities = [Bool]()
    var dataManager = DataManager.shared
    
    init(){
        for _ in 0..<Amenity.amenities.count{
            self.amenities.append(false)
        }
    }
    
    
    func createNewRoom(roomName:String, minBeds:Int, maxBeds:Int){
        var amenities = [Amenity]()
        
        for (index, element) in self.amenities.enumerated(){
            if(element==true){
                amenities.append(Amenity.amenities[index])
            }
        }
        
        dataManager.updateAndSave(room : Room(name: roomName, area: 10, minBeds: minBeds, maxBeds: maxBeds, amenities: amenities))
        
    }
    
    
    
}
