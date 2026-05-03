//
//  MoodViewModel.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
@Observable class MoodViewModel{
    
    
    var selectedMood : String = ""
    var moodNote: String = ""
    
    let availableMoods = [
        "😊", "😔", "😴", "😰", "😡", "🥰", "😎", "🤔"
    ]
    
    let moodCategories : [String : String] = [
        "😊" : "Happy",
        "😔" : "Sad",
        "😴" : "Tired",
        "😰" : "Anxious",
        "😡" : "Angry",
        "🥰" : "Loved",
        "😎" : "Confident",
        "🤔" : "Thoughtful"
        
    ]
    
    
    var modelContext : ModelContext?
    var lastSaveError: String?
    
    init(modelContext : ModelContext? = nil){
        self.modelContext = modelContext
    }
    
    
  
    @discardableResult
    func saveMoodEntry() -> Bool {
        guard !selectedMood.isEmpty, let context = modelContext else {
            lastSaveError = "Unable to save mood right now."
            return false
        }
        
        let trimmedNote = moodNote.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let newEntry = MoodModel(
            mood: selectedMood,
            note: trimmedNote
        )
        
        context.insert(newEntry)
        do {
            try context.save()
            selectedMood = ""
            moodNote = ""
            lastSaveError = nil
            return true
        } catch {
            context.delete(newEntry)
            lastSaveError = "Failed to save mood. Please try again."
            return false
        }
    }
    
    func deleteMoodEntry(_ entry: MoodModel) {
        guard let context = modelContext else {
            return
        }
        context.delete(entry)
        do {
            try context.save()
        } catch {
            lastSaveError = "Failed to delete mood entry."
        }
    }
    
    

    
    // Analytics
    
    func getMoodCount(for mood: String , entries: [MoodModel]) -> Int{
        entries.filter { $0.mood == mood }.count
        
    }
 
    func getMoodDistribution(entries: [MoodModel]) -> [(mood : String , count : Int)]{
        MoodAnalytics.moodDistribution(entries: entries)
            .map { (mood: $0.mood, count: $0.count) }
        
        
    }
    
    func getLastSevenDaysMoods(entries:[MoodModel]) -> [MoodModel] {
        guard let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date()) else {
            return entries.sorted { $0.date > $1.date }
        }
        
        return entries.filter {$0.date >= sevenDaysAgo}
            .sorted{$0.date > $1.date}
    }
    
    func getTodaysMood(entries:[MoodModel]) -> MoodModel? {
        let calendar = Calendar.current
        return entries.first { calendar.isDateInToday($0.date)}
    }
    
    func hasEnteredMoodToday(entries: [MoodModel]) -> Bool {
        return getTodaysMood(entries: entries) != nil
    }
    
   
    
  
    
    func getCurrentStreak(entries: [MoodModel]) -> Int {
            MoodAnalytics.currentStreak(entries: entries)
        }
    
}
