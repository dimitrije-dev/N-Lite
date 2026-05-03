//
//  MoodAnalytics.swift
//  N Lite
//
//  Created by Codex on 03.05.2026.
//

import Foundation

struct MoodTrendPoint: Identifiable {
    let date: Date
    let value: Double
    let didLogMood: Bool
    
    var id: Date { date }
}

struct MoodDayIntensity: Identifiable {
    let date: Date
    let count: Int
    let level: Int
    
    var id: Date { date }
}

enum MoodAnalytics {
    private static let positiveMoods: Set<String> = ["😊", "🥰", "😎"]
    private static let neutralMoods: Set<String> = ["🤔", "😴"]
    
    static func deduplicatedByDay(_ entries: [MoodModel], calendar: Calendar = .current) -> [MoodModel] {
        let sorted = entries.sorted { $0.date > $1.date }
        var seenDays = Set<Date>()
        var result: [MoodModel] = []
        
        for entry in sorted {
            let day = calendar.startOfDay(for: entry.date)
            if seenDays.insert(day).inserted {
                result.append(entry)
            }
        }
        
        return result
    }
    
    static func currentStreak(entries: [MoodModel], calendar: Calendar = .current) -> Int {
        guard !entries.isEmpty else { return 0 }
        
        let uniqueDailyEntries = deduplicatedByDay(entries, calendar: calendar)
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
    
    static func longestStreak(entries: [MoodModel], calendar: Calendar = .current) -> Int {
        guard !entries.isEmpty else { return 0 }
        
        let uniqueDailyEntries = deduplicatedByDay(entries, calendar: calendar)
        let sortedDates = uniqueDailyEntries.map { calendar.startOfDay(for: $0.date) }.sorted()
        
        guard !sortedDates.isEmpty else { return 0 }
        
        var longest = 1
        var current = 1
        
        for index in 1..<sortedDates.count {
            let previous = sortedDates[index - 1]
            let currentDate = sortedDates[index]
            let dayDiff = calendar.dateComponents([.day], from: previous, to: currentDate).day ?? 0
            
            if dayDiff == 1 {
                current += 1
                longest = max(longest, current)
            } else {
                current = 1
            }
        }
        
        return longest
    }
    
    static func moodDistribution(entries: [MoodModel]) -> [(mood: String, count: Int, percentage: Double)] {
        guard !entries.isEmpty else { return [] }
        
        var distribution: [String: Int] = [:]
        let total = entries.count
        
        for entry in entries {
            distribution[entry.mood, default: 0] += 1
        }
        
        return distribution
            .map { (mood: $0.key, count: $0.value, percentage: Double($0.value) / Double(total) * 100) }
            .sorted { $0.count > $1.count }
    }
    
    static func weeklyMoodData(entries: [MoodModel], calendar: Calendar = .current) -> [(day: String, moods: [MoodModel])] {
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
    
    static func averageMoodsPerWeek(entries: [MoodModel], calendar: Calendar = .current) -> Double {
        guard !entries.isEmpty else { return 0 }
        
        let oldestDate = entries.map { $0.date }.min() ?? Date()
        let weeks = max(1, calendar.dateComponents([.weekOfYear], from: oldestDate, to: Date()).weekOfYear ?? 1)
        
        return Double(entries.count) / Double(weeks)
    }
    
    static func mostCommonMood(entries: [MoodModel]) -> String? {
        guard !entries.isEmpty else { return nil }
        
        var moodCounts: [String: Int] = [:]
        for entry in entries {
            moodCounts[entry.mood, default: 0] += 1
        }
        
        return moodCounts.max(by: { $0.value < $1.value })?.key
    }
    
    static func timeRange(entries: [MoodModel]) -> String {
        guard !entries.isEmpty else { return "No data" }
        let sortedDates = entries.map(\.date).sorted()
        guard let oldest = sortedDates.first, let newest = sortedDates.last else { return "No data" }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return "\(formatter.string(from: oldest)) - \(formatter.string(from: newest))"
    }
    
    static func consistencyScore(entries: [MoodModel], days: Int, calendar: Calendar = .current) -> Int {
        guard days > 0 else { return 0 }
        
        let trackedDays = Set(entries.map { calendar.startOfDay(for: $0.date) })
        var logged = 0
        
        for offset in 0..<days {
            guard let date = calendar.date(byAdding: .day, value: -offset, to: Date()) else { continue }
            if trackedDays.contains(calendar.startOfDay(for: date)) {
                logged += 1
            }
        }
        
        return Int((Double(logged) / Double(days) * 100).rounded())
    }
    
    static func trendData(entries: [MoodModel], days: Int, calendar: Calendar = .current) -> [MoodTrendPoint] {
        guard days > 0 else { return [] }
        
        let grouped = Dictionary(grouping: entries) { calendar.startOfDay(for: $0.date) }
        var points: [MoodTrendPoint] = []
        
        for offset in (0..<days).reversed() {
            guard let date = calendar.date(byAdding: .day, value: -offset, to: Date()) else { continue }
            let day = calendar.startOfDay(for: date)
            let entriesForDay = grouped[day] ?? []
            let score = normalizedDayScore(entriesForDay)
            points.append(MoodTrendPoint(date: day, value: score, didLogMood: !entriesForDay.isEmpty))
        }
        
        return points
    }
    
    static func heatmapData(entries: [MoodModel], days: Int, calendar: Calendar = .current) -> [MoodDayIntensity] {
        guard days > 0 else { return [] }
        
        let groupedCounts = Dictionary(grouping: entries) { calendar.startOfDay(for: $0.date) }
            .mapValues(\.count)
        let maxCount = max(1, groupedCounts.values.max() ?? 1)
        
        var result: [MoodDayIntensity] = []
        for offset in (0..<days).reversed() {
            guard let date = calendar.date(byAdding: .day, value: -offset, to: Date()) else { continue }
            let day = calendar.startOfDay(for: date)
            let count = groupedCounts[day] ?? 0
            let level = count == 0 ? 0 : max(1, Int((Double(count) / Double(maxCount) * 4).rounded()))
            result.append(MoodDayIntensity(date: day, count: count, level: min(level, 4)))
        }
        
        return result
    }
    
    static func moodBalanceSummary(entries: [MoodModel]) -> String {
        guard !entries.isEmpty else { return "No data yet" }
        
        let latest = entries.sorted { $0.date > $1.date }.prefix(14)
        let positive = latest.filter { positiveMoods.contains($0.mood) }.count
        let neutral = latest.filter { neutralMoods.contains($0.mood) }.count
        let challenging = latest.count - positive - neutral
        
        if positive >= max(neutral, challenging) {
            return "Positive trend in the last 14 entries"
        }
        if challenging > positive {
            return "More challenging moods recently"
        }
        return "Balanced mood pattern recently"
    }
    
    private static func normalizedDayScore(_ entries: [MoodModel]) -> Double {
        guard !entries.isEmpty else { return 0 }
        
        let scores = entries.map { moodScore(for: $0.mood) }
        let average = scores.reduce(0, +) / Double(scores.count)
        return min(max(average, 0), 100)
    }
    
    private static func moodScore(for mood: String) -> Double {
        switch mood {
        case "🥰": return 100
        case "😊": return 90
        case "😎": return 80
        case "🤔": return 60
        case "😴": return 50
        case "😔": return 35
        case "😰": return 25
        case "😡": return 15
        default: return 50
        }
    }
}
