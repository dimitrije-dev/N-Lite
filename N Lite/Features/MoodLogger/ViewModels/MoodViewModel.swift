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
        var distribution: [String : Int] = [:]
        
        for entry in entries {
            distribution[entry.mood, default: 0] += 1
        }
        
        return distribution.map { (mood: $0.key, count: $0.value) }
            .sorted { $0.count > $1.count }
        
        
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
            guard !entries.isEmpty else { return 0 }
            
            let sortedEntries = entries.sorted { $0.date > $1.date }
            let calendar = Calendar.current
            var seenDays = Set<Date>()
            var uniqueDailyEntries: [MoodModel] = []
            
            for entry in sortedEntries {
                let day = calendar.startOfDay(for: entry.date)
                if seenDays.insert(day).inserted {
                    uniqueDailyEntries.append(entry)
                }
            }
            
            var streak = 0
            var expectedDate = Date()
            
            for entry in uniqueDailyEntries {
                if calendar.isDate(entry.date, inSameDayAs: expectedDate) {
                    streak += 1
                    guard let previousDay = calendar.date(byAdding: .day, value: -1, to: expectedDate) else {
                        break
                    }
                    expectedDate = previousDay
                } else {
                    break
                }
            }
            return streak
        }
    
}
