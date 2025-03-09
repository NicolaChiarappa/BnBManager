//
//  SettingsView.swift
//  BnBManager
//
//  Created by Nicola Chiarappa on 10/02/25.
//

import SwiftUI

struct SettingsView: View {
    @State var isBooking:Bool=true
    @State var isAir:Bool=true
    @State var isWebsite:Bool=true
    @State var isCreateRoomActive = false
    
    var viewModel = SettingsViewModel()
    var body: some View {
        NavigationStack{
            List{
                Section("Providers") {
                    Toggle("Booking", isOn: $isBooking )
                    Toggle("Airbnb", isOn: $isAir )
                    Toggle("Website", isOn: $isWebsite )
                }
                Section("Rooms"){
                    ForEach(viewModel.dataManager.rooms, id: \.self){
                        room in
                        Text(room.name)
                            
                            
                    }
                    .onDelete(perform: viewModel.delete)
                    
                    
                    Button("Create new room") {
                        isCreateRoomActive = true
                    }
                    .foregroundStyle(Color(.link))
                    .sheet(isPresented: $isCreateRoomActive, content: {
                        CreateRoomView()
                            
                    })
                    
                    
                }
                
            }
            
            .onAppear{
                viewModel.fetch()
            }
            
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
