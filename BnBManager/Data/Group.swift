//
//  Group.swift
//  BnBManager
//
//  Created by Nicola Chiarappa on 10/02/25.
//
import SwiftUI

struct Group{
    init(leader:Person, group:[Person]=[]) throws{
        if(!leader.isGroupLeader) {throw NSError()}
        
        groupLeader=leader;
        self.group=group;
    }
    
    let groupLeader:Person
    let group:[Person]
    
    func getLeader()->Person{
        return self.groupLeader
    }
    
    
    func getCount()->Int{
        return 1+group.count
    }
    
    func description()->String{
        var description:String = ""
        for person in group{
            description.append(
                "\(person.firstName) \t \(person.lastName)  \n  \(person.birthDate) \n Document n.\(person.document?.idNumber ?? "vuoto") "
            )
        }
        return description
    }
    
    
    
}
