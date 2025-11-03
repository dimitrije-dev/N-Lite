//
//  ContentView.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack{
            Color.backgroundColorCustom.ignoresSafeArea(edges: .all)
            TabView(selection: $selectedTab){
                Tab("Home", systemImage: "house", value: 0){
                    NavigationStack {
                        HomeView(selectedTab: $selectedTab)
                    }
                }
                Tab("Log", systemImage: "face.smiling", value: 1){
                    NavigationStack {
                        MoodLoggerView()
                    }
                }
                Tab("Progress" , systemImage: "chart.pie.fill", value :2 ){
                    NavigationStack{
                        ProgressView()
                    }
                }
                
                Tab("Settings", systemImage: "gear", value: 3){
                    NavigationStack {
                        SettingsView()
                    }
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
