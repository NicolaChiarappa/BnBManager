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
    var minBeds:Int = 1
    var maxBeds:Int = 1 {
        didSet{
            print(maxBeds)
        }
    }
    var roomName:String = ""
    var doneDisabled:Bool{minBeds<1 || maxBeds<minBeds || roomName.isEmpty}
    
    init(){
        for _ in 0..<Amenity.amenities.count{
            self.amenities.append(false)
        }
    }
    
    
    func createNewRoom(){
        var amenities = [Amenity]()
        
        for (index, element) in self.amenities.enumerated(){
            if(element==true){
                amenities.append(Amenity.amenities[index])
            }
        }
        
        dataManager.updateAndSave(room : Room(name: roomName, area: 10, minBeds: minBeds, maxBeds: maxBeds, amenities: amenities))
        
    }
    
    
    
}
