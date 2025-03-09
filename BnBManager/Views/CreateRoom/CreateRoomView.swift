//
//  CreateRoomView.swift
//  BnBManager
//
//  Created by Nicola Chiarappa on 11/02/25.
//

import SwiftUI

struct CreateRoomView: View {
    @StateObject var viewModel:CreateRoomViewModel = CreateRoomViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            Form {
                Section("name"){
                    TextField("Room name", text: $viewModel.roomName)
                }
                
                Section("beds"){
                    HStack{
                        
                        
                        VStack{
                            Text("Minimum beds".uppercased())
                                .foregroundStyle(Color.secondary)
                            Picker("", selection: $viewModel.minBeds){
                                ForEach(1..<11, id: \.self) { i in
                                    Text(i.description)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(height:120)
                            .onChange(of: viewModel.minBeds) { oldValue, newValue in
                                viewModel.maxBeds=newValue
                            }
                        }
                        
                        
                        VStack{
                            Text("Maximum beds".uppercased())
                                .foregroundStyle(Color.secondary)
                            Picker("", selection: $viewModel.maxBeds) {
                                ForEach(1..<11, id:\.self) { i in
                                    if(i>=viewModel.minBeds){
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
                    ForEach(Amenity.amenities, id:\.code){ amenity in
                        let indice = Amenity.amenities.firstIndex(of: amenity)
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
                            viewModel.createNewRoom()
                            dismiss()
                        }
                        .disabled(viewModel.doneDisabled)
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
