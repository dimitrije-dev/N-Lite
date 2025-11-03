//
//  MoodMOdel.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import Foundation

struct MoodModel: Identifiable , Codable {
    let id : UUID
    let mood: String
    let date: Date
    let note: String
    
    init(id: UUID = UUID(), mood: String, date: Date = Date(), note: String ) {
        self.id = id
        self.mood = mood
        self.date = date
        self.note = note
    }
    
}
