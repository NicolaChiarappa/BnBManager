//
//  ContentView.swift
//  BnBManager
//
//  Created by Nicola Chiarappa on 03/02/25.
//

import SwiftUI

struct ContentView: View {
    var nicola = Person(firstName: "Nicola", lastName: "Chiarappa", birthDate: .now, gender: .male)
    
    
    var body: some View {
        TabView{
            Tab(content: {
                HomeView()
            }){
                Label("Overview", systemImage: "note")
            }
            Tab(content: {
                SettingsView()
            }){
                Label("Settings", systemImage: "gear")
            }
            
            
        }
    }
}







#Preview {
    ContentView()
}



