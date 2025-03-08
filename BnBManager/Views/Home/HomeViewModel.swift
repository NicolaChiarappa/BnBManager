//
//  HomeViewModel.swift
//  BnBManager
//
//  Created by Nicola Chiarappa on 10/02/25.
//
import SwiftUI


class HomeViewModel: ObservableObject{
    var isArrivingActive:Bool = false
    
    let dataManager = DataManager()
    
    func fetch(){
        dataManager.fetchRooms()
    }
    
    func many(){
        dataManager.manyRooms()
    }
    
    
    
    
    
}
