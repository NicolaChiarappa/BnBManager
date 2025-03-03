//
//  Group.swift
//  BnBManager
//
//  Created by Nicola Chiarappa on 10/02/25.
//
import SwiftUI

struct Group{
    private var groupLeader:Guest
    private var group:[Guest]
    
    
    init(leader:Guest, group:[Guest]=[]) throws{
        
        self.group=[]
        self.group.append(leader)
        self.groupLeader=leader;
        self.group.append(contentsOf: group)
    }
    
    
    
    func getLeader()->Guest{
        return self.groupLeader
    }
    
    
    func getCount()->Int{
        return group.count
    }
    
    mutating func addGuest(guest:Guest){
        self.group.append(guest)
    }
    
    mutating func deleteGuest(guest:Guest, newLeader:Guest? = nil) throws{
        if(guest == self.groupLeader){
            if(newLeader == nil) {throw NSError()}
            if(newLeader!.getAge()<18){throw NSError()}
            if(!(self.group.contains(where: { tempGuest in
                tempGuest==newLeader
            }))){
                self.addGuest(guest: newLeader!)
                try! self.deleteGuest(guest: guest, newLeader: newLeader)
            }
        }
        group.remove(at: group.firstIndex(of: guest)!)
    }
    
    
    func description()->String{
        var description:String = ""
        for person in group{
            description.append(
                "\(person.firstName) \(person.lastName) \(person.birthDate.formatted(date: .abbreviated, time: .omitted)) Document n.\(person.document?.idNumber ?? IdDocument.nullDoc.idNumber) "
            )
        }
        return description
    }
    
    
    
}
