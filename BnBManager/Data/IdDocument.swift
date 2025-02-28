
//
//  Document.swift
//  BnBManager
//
//  Created by Nicola Chiarappa on 10/02/25.
//

import Foundation

struct IdDocument{
    let docType:DocType
    let idNumber:String
    let firstName:String
    let lastName:String
    let expireDate:Date
    let releaseDate:Date
    let agencyType:String
}


enum DocType:String{
    case driveLicense = "Drive License"
    case identityCard = "Identity Card"
    case passport = "Passport"
}
