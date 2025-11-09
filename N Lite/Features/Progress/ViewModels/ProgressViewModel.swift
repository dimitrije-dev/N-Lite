//
//  ProgressViewModel.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 7. 11. 2025..
//

import Foundation
import SwiftUI

@Observable class ProgressViewModel {
    
    // MARK: - Analytics Methods
    
    func getMoodDistribution(entries: [MoodModel]) -> [(mood: String, count: Int, percentage: Double)] {
        var distribution: [String: Int] = [:]
        let total = entries.count
        
        for entry in entries {
            distribution[entry.mood, default: 0] += 1
        }
        
        return distribution.map { (mood: $0.key, count: $0.value, percentage: total > 0 ? Double($0.value) / Double(total) * 100 : 0) }
            .sorted { $0.count > $1.count }
    }
    
    func getWeeklyMoodData(entries: [MoodModel]) -> [(day: String, moods: [MoodModel])] {
        let calendar = Calendar.current
        let today = Date()
        
        var weekData: [(day: String, moods: [MoodModel])] = []
        
        for dayOffset in (0..<7).reversed() {
            guard let date = calendar.date(byAdding: .day, value: -dayOffset, to: today) else { continue }
            
            let dayMoods = entries.filter { calendar.isDate($0.date, inSameDayAs: date) }
            let dayName = date.formatted(.dateTime.weekday(.abbreviated))
            
            weekData.append((day: dayName, moods: dayMoods))
        }
        
        return weekData
    }
    
    func getCurrentStreak(entries: [MoodModel]) -> Int {
        guard !entries.isEmpty else { return 0 }
        
        let sortedEntries = entries.sorted { $0.date > $1.date }
        let calendar = Calendar.current
        var streak = 0
        var expectedDate = Date()
        
        for entry in sortedEntries {
            if calendar.isDate(entry.date, inSameDayAs: expectedDate) {
                streak += 1
                expectedDate = calendar.date(byAdding: .day, value: -1, to: expectedDate)!
            } else {
                break
            }
        }
        return streak
    }
    
    func getLongestStreak(entries: [MoodModel]) -> Int {
        guard !entries.isEmpty else { return 0 }
        
        let sortedEntries = entries.sorted { $0.date < $1.date }
        let calendar = Calendar.current
        
        var longestStreak = 0
        var currentStreak = 1
        
        for i in 1..<sortedEntries.count {
            let previousDate = sortedEntries[i-1].date
            let currentDate = sortedEntries[i].date
            
            if let dayDifference = calendar.dateComponents([.day], from: previousDate, to: currentDate).day,
               dayDifference == 1 {
                currentStreak += 1
            } else if !calendar.isDate(previousDate, inSameDayAs: currentDate) {
                longestStreak = max(longestStreak, currentStreak)
                currentStreak = 1
            }
        }
        
        return max(longestStreak, currentStreak)
    }
    
    func getAverageMoodsPerWeek(entries: [MoodModel]) -> Double {
        guard !entries.isEmpty else { return 0 }
        
        let calendar = Calendar.current
        let oldestDate = entries.map { $0.date }.min() ?? Date()
        let weeks = calendar.dateComponents([.weekOfYear], from: oldestDate, to: Date()).weekOfYear ?? 1
        
        return weeks > 0 ? Double(entries.count) / Double(weeks) : Double(entries.count)
    }
    
    func getMostCommonMood(entries: [MoodModel]) -> String? {
        guard !entries.isEmpty else { return nil }
        
        var moodCounts: [String: Int] = [:]
        for entry in entries {
            moodCounts[entry.mood, default: 0] += 1
        }
        
        return moodCounts.max(by: { $0.value < $1.value })?.key
    }
    
    func getTimeRange(entries: [MoodModel]) -> String {
        guard !entries.isEmpty else { return "No data" }
        
        let sortedDates = entries.map { $0.date }.sorted()
        guard let oldest = sortedDates.first, let newest = sortedDates.last else { return "No data" }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return "\(formatter.string(from: oldest)) - \(formatter.string(from: newest))"
    }
}
