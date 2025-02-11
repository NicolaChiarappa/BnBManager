//
//  ContentView.swift
//  BnBManager
//
//  Created by Nicola Chiarappa on 03/02/25.
//

import SwiftUI

struct ContentView: View {
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



