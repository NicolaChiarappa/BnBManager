import Foundation

protocol Person:Equatable{
    var id: UUID {get}
    var firstName: String {get}
    var lastName: String {get}
    var birthDate: Date {get}
    var gender: Gender {get}
    var document:IdDocument? {get}
    
    
    
    
    mutating func insertDocument(doc:IdDocument)
    
    func getName()->String
    
    func getBirthDate()->Date
    
    func getGender()->Gender
    
    func getDocument()->IdDocument
    
    func getBirthDateDescription() -> String
    
    func getAge()->Int
    
    
    
}


enum Gender{
    case male
    case female
}
