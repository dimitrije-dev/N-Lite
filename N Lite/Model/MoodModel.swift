//
//  MoodMOdel.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import Foundation

struct MoodModel : Identifiable{
    let id = UUID()
    let mood: String
    let date: Date
    let note : String
}
