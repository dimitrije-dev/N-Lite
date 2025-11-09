//
//  WeeklyOverview.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 7. 11. 2025..
//

import SwiftUI

struct WeeklyOverview: View {
    let weekData: [(day: String, moods: [MoodModel])]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            Text("This Week")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundStyle(.primary)
            
            HStack(spacing: 8) {
                ForEach(weekData, id: \.day) { dayData in
                    DayColumn(day: dayData.day, moods: dayData.moods)
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 4)
        )
    }
}

struct DayColumn: View {
    let day: String
    let moods: [MoodModel]
    
    private let maxHeight: CGFloat = 100
    
    var body: some View {
        VStack(spacing: 8) {
            // Mood indicators
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.primaryColorCustom.opacity(0.1))
                    .frame(height: maxHeight)
                
                if !moods.isEmpty {
                    VStack(spacing: 2) {
                        ForEach(moods.prefix(3)) { mood in
                            Text(mood.mood)
                                .font(.system(size: moods.count > 2 ? 16 : 20))
                        }
                        
                        if moods.count > 3 {
                            Text("+\(moods.count - 3)")
                                .font(.system(size: 10, weight: .semibold, design: .rounded))
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color.primaryColorCustom.opacity(0.3),
                                        Color.secondaryColorCustom.opacity(0.3)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    )
                    .frame(height: calculateHeight())
                }
            }
            
            // Day label
            Text(day)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundStyle(moods.isEmpty ? .tertiary : .primary)
        }
        .frame(maxWidth: .infinity)
    }
    
    private func calculateHeight() -> CGFloat {
        if moods.isEmpty { return 0 }
        let moodCount = min(moods.count, 5)
        return maxHeight * (CGFloat(moodCount) / 5.0)
    }
}

#Preview {
    let calendar = Calendar.current
    let today = Date()
    
    let sampleWeekData = [
        (day: "Mon", moods: [
            MoodModel(mood: "😊", note: "Good day"),
            MoodModel(mood: "🥰", note: "Great evening")
        ]),
        (day: "Tue", moods: [MoodModel(mood: "😴", note: "Tired")]),
        (day: "Wed", moods: []),
        (day: "Thu", moods: [
            MoodModel(mood: "😊", note: "Productive"),
            MoodModel(mood: "😎", note: "Confident"),
            MoodModel(mood: "🤔", note: "Thoughtful")
        ]),
        (day: "Fri", moods: [MoodModel(mood: "🥰", note: "Happy Friday!")]),
        (day: "Sat", moods: [MoodModel(mood: "😊", note: "Relaxed")]),
        (day: "Sun", moods: [])
    ]
    
    return WeeklyOverview(weekData: sampleWeekData)
        .padding()
}
