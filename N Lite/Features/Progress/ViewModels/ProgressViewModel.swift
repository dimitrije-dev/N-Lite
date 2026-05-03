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
        MoodAnalytics.moodDistribution(entries: entries)
    }
    
    func getWeeklyMoodData(entries: [MoodModel]) -> [(day: String, moods: [MoodModel])] {
        MoodAnalytics.weeklyMoodData(entries: entries)
    }
    
    func getCurrentStreak(entries: [MoodModel]) -> Int {
        MoodAnalytics.currentStreak(entries: entries)
    }
    
    func getLongestStreak(entries: [MoodModel]) -> Int {
        MoodAnalytics.longestStreak(entries: entries)
    }
    
    func getAverageMoodsPerWeek(entries: [MoodModel]) -> Double {
        MoodAnalytics.averageMoodsPerWeek(entries: entries)
    }
    
    func getMostCommonMood(entries: [MoodModel]) -> String? {
        MoodAnalytics.mostCommonMood(entries: entries)
    }
    
    func getTimeRange(entries: [MoodModel]) -> String {
        MoodAnalytics.timeRange(entries: entries)
    }
    
    func getTrendData(entries: [MoodModel], days: Int = 14) -> [MoodTrendPoint] {
        MoodAnalytics.trendData(entries: entries, days: days)
    }
    
    func getConsistencyScore(entries: [MoodModel], days: Int = 30) -> Int {
        MoodAnalytics.consistencyScore(entries: entries, days: days)
    }
    
    func getHeatmapData(entries: [MoodModel], days: Int = 28) -> [MoodDayIntensity] {
        MoodAnalytics.heatmapData(entries: entries, days: days)
    }
    
    func getMoodBalanceSummary(entries: [MoodModel]) -> String {
        MoodAnalytics.moodBalanceSummary(entries: entries)
    }
}
