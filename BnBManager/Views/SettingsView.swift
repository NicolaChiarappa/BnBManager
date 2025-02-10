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
    
    var body: some View {
        NavigationStack{
            List{
                Section("Providers") {
                    Toggle("Booking", isOn: $isBooking )
                    Toggle("Airbnb", isOn: $isAir )
                    Toggle("Website", isOn: $isWebsite )
                }
            }
            
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
