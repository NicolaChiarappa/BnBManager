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
    
    init(){
        for _ in 0..<Room.roomAmenities.count{
            self.amenities.append(false)
        }
    }
    
    
    func createNewRoom(roomName:String, minBeds:Int, maxBeds:Int){
        var amenities = [Amenity]()
        
        for (index, element) in self.amenities.enumerated(){
            if(element==true){
                amenities.append(Room.roomAmenities[index])
            }
        }
        
        //        rooms.append(Room(name: roomName, minBeds: minBeds, maxBeds: maxBeds, amenities: amenities))
        
    }
    
    
    
}
