//
//  BnBManagerTests.swift
//  BnBManagerTests
//
//  Created by Nicola Chiarappa on 11/02/25.
//

import XCTest
import Foundation
import CoreData
@testable import BnBManager


final class BnBManagerTests: XCTestCase {
    
    func testBookDescription(){
        
        let myDoc=IdDocument(docType: .identityCard, idNumber: "123", firstName: "Nicola", lastName: "Chiarappa", expireDate: Date.distantFuture, releaseDate: Date.distantPast, agencyType: "Comune")
        
        let formatter=DateFormatter()
        formatter.dateStyle = .short
        let myBirthDate = formatter.date(from: "14/02/01")
        
        let me = Guest(firstName: "Nicola", lastName: "Chiarappa", birthDate: myBirthDate!, gender: .male, document: myDoc, isGroupLeader: true)
        
        do{
            let myGroup = try Group(leader: me)
            print(" \n \(myGroup.description()) \n")
            
        }
        catch{
            print("error")
            
        }
        
    }
    
    
    

    
    func testCoreData(){
        
        
        let persistentForTests = DataManager()
        DataManager.resetDatabase(persistentContainer: persistentForTests.container)
        persistentForTests.fetchRooms()
        
        XCTAssert(persistentForTests.roomsDict.isEmpty)
        let newRoom = Room(name: "Nicola's", area: 12, minBeds: 2, maxBeds: 5, amenities: [])
        
        persistentForTests.updateAndSave(room: newRoom)
        XCTAssert(persistentForTests.roomsDict[newRoom.id]?.name=="Nicola's")
        
        persistentForTests.roomsDict[newRoom.id]?.name="Giacomo's"
        persistentForTests.updateAndSave(room:persistentForTests.roomsDict[newRoom.id]!)
        XCTAssert(persistentForTests.roomsDict[newRoom.id]?.name=="Giacomo's")
        
        
    }
    
}
