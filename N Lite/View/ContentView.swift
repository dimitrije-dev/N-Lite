//
//  ContentView.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Tab("Home", systemImage: "house"){
                HomeView()
            }
            Tab("Log", systemImage: "face.smiling"){
                MoodLoggerView()
            }
            
            Tab("Settings", systemImage: "gear"){
                SettingsView()
            }
            
            
            
        }
        
    }
}

#Preview {
    ContentView()
}
