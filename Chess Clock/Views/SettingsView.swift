//
//  SettingsView.swift
//  Chess Clock
//
//  Created by Kamil Kozioł on 07/04/2021.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    Picker(selection: $settings.counter, label: Text("Time")) {
                        Text("Bullet (1 min)").tag(1 * 60)
                        Text("Bullet (2 min)").tag(2 * 60)
                        Text("Blitz (3 min)").tag(3 * 60)
                        Text("Blitz (5 min)").tag(5 * 60)
                        Text("Rapid (10 min)").tag(10 * 60)
                        Text("Standard (15 min)").tag(15 * 60)
                    }
                    
                    Picker(selection: $settings.increment, label: Text("Increment")) {
                        Text("0s").tag(0)
                        Text("1s").tag(1)
                        Text("2s").tag(2)
                        Text("5s").tag(5)
                        Text("10s").tag(10)
                    }
                }
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .edgesIgnoringSafeArea(.all)
            .background(Color.black)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Settings())
    }
}
