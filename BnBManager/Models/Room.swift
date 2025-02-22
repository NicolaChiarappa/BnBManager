//
//  Room.swift
//  BnBManager
//
//  Created by Nicola Chiarappa on 10/02/25.
//

import Foundation

struct Room:Codable{
    var ID:UUID = UUID()
    let name:String
    let minBeds:Int
    let maxBeds:Int
    var amenities:[Amenity]
    
    init(name: String, minBeds: Int, maxBeds: Int, amenities:[Amenity]) {
        self.name = name
        self.minBeds = minBeds
        self.maxBeds = maxBeds
        self.amenities = amenities
       
     
    }
    
    
    static let roomAmenities = [
        Amenity(code: 0, name: "WiFi"),
        Amenity(code: 1, name: "Aria condizionata"),
        Amenity(code: 2, name: "Cucina"),
        Amenity(code: 3, name: "Frigorifero"),
        Amenity(code: 4, name: "Forno a microonde"),
        Amenity(code: 5, name: "TV"),
        Amenity(code: 6, name: "Balcone"),
        Amenity(code: 7, name: "Scrivania"),
        Amenity(code: 8, name: "Asciugacapelli"),
        Amenity(code: 9, name: "Cassaforte")
    ]
}




