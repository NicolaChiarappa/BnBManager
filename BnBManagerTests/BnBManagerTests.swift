//
//  BnBManagerTests.swift
//  BnBManagerTests
//
//  Created by Nicola Chiarappa on 11/02/25.
//

import XCTest
import Foundation
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
    
}
