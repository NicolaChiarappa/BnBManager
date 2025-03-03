//
//  Guest.swift
//  BnBManager
//
//  Created by Nicola Chiarappa on 02/03/25.
//

import Foundation

struct Guest:Person{
    
    
    
    internal var id: UUID
    
    internal var firstName: String
    
    internal var lastName: String
    
    internal var birthDate: Date
    
    internal var gender: Gender
    
    internal var document: IdDocument?
    
    
    
    
    
    
    init(id: UUID = UUID(), firstName: String, lastName: String, birthDate: Date, gender: Gender, document: IdDocument? = nil, isGroupLeader: Bool=false) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
        self.gender = gender
        self.document = document
    }
    
    
    mutating func insertDocument(doc: IdDocument) {
        self.document=doc
    }
    
    func getName() -> String {
        return ("\(self.firstName) \(self.lastName)")
    }
    
    func getBirthDateDescription() -> String {
        return self.birthDate.formatted(date: .abbreviated, time: .omitted)
    }
    
    func getBirthDate() -> Date {
        return self.birthDate
    }
    
    func getAge()->Int{
        return Calendar.current.dateComponents([.year], from: self.birthDate, to: .now).year!
        
    }
    
    
    func getGender() -> Gender {
        return self.gender
    }
    
    func getDocument() -> IdDocument {
        return self.document ?? IdDocument.nullDoc
    }
    
    
    
    static func == (lhs: Guest, rhs: Guest) -> Bool {
        return lhs.id==rhs.id
    }
}
