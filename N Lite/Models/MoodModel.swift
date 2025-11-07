//
//  MoodMOdel.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import Foundation
import SwiftData


@Model
final class MoodModel {
    var id : UUID
    var mood: String
    var date: Date
    var note: String
    
    init(id: UUID = UUID(), mood: String, date: Date = Date(), note: String ) {
        self.id = id
        self.mood = mood
        self.date = date
        self.note = note
    }
    
}
