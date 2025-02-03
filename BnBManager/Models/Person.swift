import Foundation

struct Person{
    var firstName: String
    var lastName: String
    var birthDate: Date
    var gender: Gender
}


enum Gender: Character{
    case male = "M"
    case female = "F"
}
