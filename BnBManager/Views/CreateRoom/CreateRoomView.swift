//
//  CreateRoomView.swift
//  BnBManager
//
//  Created by Nicola Chiarappa on 11/02/25.
//

import SwiftUI

struct CreateRoomView: View {
    @StateObject var viewModel:CreateRoomViewModel = CreateRoomViewModel()
    @State var minBeds:Int = 0
    @State var maxBeds:Int = 0
    @State var roomName:String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            Form {
                Section("name"){
                    TextField("Room name", text: $roomName)
                }
                
                Section("beds"){
                    HStack{
                        
                        
                        VStack{
                            Text("Minimum beds".uppercased())
                                .foregroundStyle(Color.secondary)
                            Picker("", selection: $minBeds){
                                ForEach(1..<11) { i in
                                    Text(i.description)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(height:120)
                            .onChange(of: minBeds) { oldValue, newValue in
                                maxBeds=newValue
                            }
                        }
                        
                        
                        VStack{
                            Text("Maximum beds".uppercased())
                                .foregroundStyle(Color.secondary)
                            Picker("", selection: $maxBeds) {
                                ForEach(1..<11) { i in
                                    if(i>minBeds){
                                        Text(i.description)
                                    }
                                    
                                }
                            }
                            .frame(height:120)
                            .pickerStyle(.wheel)
                            
                        }
                    }
                }
                Section("amenities"){
                    ForEach(Room.roomAmenities, id:\.code){ amenity in
                        let indice = Room.roomAmenities.firstIndex(of: amenity)
                        Toggle(
                            amenity.name,
                            isOn: $viewModel.amenities[indice!]
                        )
                        
                    }
                    
                }
                
                
                
            }
            .toolbar(
                content: {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel"){
                            dismiss()
                        }
                    }
                    ToolbarItem {
                        
                        Button("Done"){
                            viewModel
                                .createNewRoom(
                                    roomName: roomName,
                                    minBeds: minBeds,
                                    maxBeds: maxBeds
                                )
                            dismiss()
                        }
                        .bold()
                    }
                })
            
            .navigationTitle("Create room")
        }
    }
}

#Preview {
    CreateRoomView()
}
