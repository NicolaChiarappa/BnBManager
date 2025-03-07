//
//  Room.swift
//  BnBManager
//
//  Created by Nicola Chiarappa on 10/02/25.
//

import Foundation

struct Room:Codable, Hashable{
    var ID:UUID = UUID()
    let name:String
    let area:Int
    let minBeds:Int
    let maxBeds:Int
    var amenities:[Amenity]
    var valuation:Float
    
    init(name: String, area:Int, minBeds: Int, maxBeds: Int, amenities:[Amenity]) {
        self.name = name
        self.area = area
        self.minBeds = minBeds
        self.maxBeds = maxBeds
        self.amenities = amenities
        self.valuation=0.0
        self.valuation=computeValuation()
    }
    
    func computeValuation()->Float{
        return (Float(amenities.count+area)+(Float(minBeds+maxBeds)/2.0))/100
    }
    
    
}




