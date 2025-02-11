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
        
        let me = Person(isGroupLeader: true, firstName: "Nicola", lastName: "Chiarappa", birthDate: Date.now, gender: .male, document: myDoc)
        
        let myGroup = try! Group(leader: me)
        
        print(myGroup.description())
    }
    
}
