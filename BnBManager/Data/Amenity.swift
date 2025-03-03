struct Amenity:Hashable, Codable{
    let code:Int
    let name:String
    
    static let amenities = [
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
