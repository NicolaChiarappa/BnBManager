import Foundation

struct Person{
    var isGroupLeader:Bool
    let firstName: String
    let lastName: String
    let birthDate: Date
    let gender: Gender
    var document:IdDocument?
    
    init(isGroupLeader: Bool=false, firstName: String, lastName: String, birthDate: Date, gender: Gender, document: IdDocument? = nil) {
        self.isGroupLeader = isGroupLeader
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
        self.gender = gender
        self.document = document
    }
    
    
    mutating func insertDocument(doc:IdDocument){
        self.document = doc
    }
    
    
}


enum Gender{
    case male
    case female
}
