//
//  N_LiteApp.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import SwiftUI
import SwiftData

@main
struct N_LiteApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for : MoodModel.self)
    }
}
