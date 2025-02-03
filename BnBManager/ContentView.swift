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
                Home()
            }){
                Label("Home", systemImage: "house")
            }
            
            
        }
    }
}





struct Home : View{
    var body : some View{
        NavigationStack{
            
            VStack{
                ScrollView(.horizontal){
                    HStack(spacing: 15) {
                        Text("Oggi")
                            .padding()
                            .selected()
                        
                        Text("Domani")
                            .padding()
                            .selected()
                        ForEach(2..<5){ i in
                            Text(i.description + " giorni")
                                .padding()
                                .selected()
                            
                        }
                        
                    }
                    .font(.callout)
                    
                    
                    
                }
                .scrollIndicators(.hidden)
                .frame(maxWidth: .infinity)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .navigationTitle("Home")
        }
    }
}

struct Selected: ViewModifier{
    func body(content: Content) -> some View {
        content
            .background(.secondary)
            .clipShape(.capsule)
            .bold()
            .foregroundStyle(.primary)
    }
}


extension View{
    func selected()->some View{
        modifier(Selected())
    }
}








#Preview {
    ContentView()
}
