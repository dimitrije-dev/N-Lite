//
//  MoodViewModel.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import Foundation
import SwiftUI

@Observable class MoodViewModel{
    var moodEntries: [MoodModel] = []
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
    
    private let storageKey: String = "moodEntries"
    
    
    init(){
        loadMoodEntires()
    }
    
    func saveMoodEntry (){
        guard !selectedMood.isEmpty else {return}
        
        let newEntry = MoodModel(mood: selectedMood, note: moodNote.isEmpty ? "No note" : moodNote)
        
        moodEntries.append(newEntry)
        
        saveToPersistance()
        
        selectedMood = ""
        moodNote = ""
        
        
        
        
    }
    
    private func saveToPersistance(){
        if let encoded = try? JSONEncoder().encode(moodEntries){
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
    
    private func loadMoodEntires(){
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([MoodModel].self, from: data) else {
            loadSampleData()
            return
        }
        
        moodEntries = decoded
    }
    
    
    private  func loadSampleData(){
        let calendar = Calendar.current
        let today = Date()
        
        let sampleMoods = [
            MoodModel(mood: "😊", date: calendar.date(byAdding: .day, value: -6, to: today)!, note: "Had a great day at work"),
            MoodModel(mood: "🤔", date: calendar.date(byAdding: .day, value: -5, to: today)!, note: "Feeling contemplative"),
            MoodModel(mood: "😴", date: calendar.date(byAdding: .day, value: -4, to: today)!, note: "Very tired today"),
            MoodModel(mood: "😊", date: calendar.date(byAdding: .day, value: -3, to: today)!, note: "Went for a nice walk"),
            MoodModel(mood: "😰", date: calendar.date(byAdding: .day, value: -2, to: today)!, note: "Bit stressed about deadlines"),
            MoodModel(mood: "🥰", date: calendar.date(byAdding: .day, value: -1, to: today)!, note: "Spent time with family"),
            MoodModel(mood: "😎", date: today, note: "Feeling confident about my progress"),
        ]
        
        moodEntries = sampleMoods
    }
    
    
    
    // Analytics
    
    func getMoodCount(for mood: String) -> Int {
        moodEntries.filter {$0.mood == mood}.count
    }
    
    func getMoodDistribution() -> [(mood : String , count : Int)]{
        var distribution: [String : Int] = [:]
        
        for entry in moodEntries {
            distribution[entry.mood ,default : 0] += 1
        }
        
        return distribution.map { (mood: $0.key, count: $0.value) }
            .sorted { $0.count > $1.count }
        
        
    }
    
    func getLastSevenDaysMoods() -> [MoodModel] {
        let sevenDaysAgo = Calendar.current.date(byAdding: .day , value: -7, to : Date())!
        
        return moodEntries.filter {$0.date >= sevenDaysAgo}
            .sorted{$0.date > $1.date}
    }
    
    func getTodaysMood() -> MoodModel? {
        let calendar = Calendar.current
        return moodEntries.first { calendar.isDateInToday($0.date)}
    }
    
    func deleteMoodEntry(_ entry: MoodModel) {
        moodEntries.removeAll { $0.id == entry.id}
        saveToPersistance()
    }
    
    var hasEnteredMoodToday : Bool {
        getTodaysMood() != nil
    }
    
    var currentStreak : Int {
        guard !moodEntries.isEmpty else {return 0}
        
        let sortedEntries = moodEntries.sorted{$0.date > $1.date}
        let calendar = Calendar.current
        var streak = 0
        var checkDate = Date()
        
        for entry in sortedEntries {
            if calendar.isDate(entry.date, inSameDayAs: checkDate) {
                streak += 1
                checkDate = calendar.date(byAdding: .day, value: -1, to: checkDate)!
            } else if calendar.isDate(entry.date, inSameDayAs: calendar.date(byAdding: .day, value: -1, to: checkDate)!) {
                checkDate = calendar.date(byAdding: .day, value: -1, to: checkDate)!
                streak += 1
                checkDate = calendar.date(byAdding: .day, value: -1, to: checkDate)!
            } else {
                break
            }
        }
        
        return streak
    }
    
    
    
    
    
}
