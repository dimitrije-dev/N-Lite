//
//  MoodDistributionChart.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 7. 11. 2025..
//

import SwiftUI

struct MoodDistributionChart: View {
    let distribution: [(mood: String, count: Int, percentage: Double)]
    let moodCategories: [String: String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            Text("Mood Distribution")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundStyle(.primary)
            
            if distribution.isEmpty {
                emptyState
            } else {
                moodBars
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 4)
        )
    }
    
    private var moodBars: some View {
        VStack(spacing: 12) {
            ForEach(distribution, id: \.mood) { item in
                MoodBar(
                    mood: item.mood,
                    category: moodCategories[item.mood] ?? "Unknown",
                    count: item.count,
                    percentage: item.percentage
                )
            }
        }
    }
    
    private var emptyState: some View {
        Text("No mood data available yet")
            .font(.system(size: 14, weight: .regular, design: .rounded))
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.primaryColorCustom.opacity(0.05))
            )
    }
}

struct MoodBar: View {
    let mood: String
    let category: String
    let count: Int
    let percentage: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(mood)
                    .font(.system(size: 24))
                
                Text(category)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text("\(count)")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(.primary)
                    
                    Text(String(format: "%.1f%%", percentage))
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundStyle(.secondary)
                }
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color.primaryColorCustom.opacity(0.1))
                    
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [Color.primaryColorCustom, Color.secondaryColorCustom],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * (percentage / 100))
                }
            }
            .frame(height: 12)
        }
    }
}

#Preview {
    let sampleDistribution = [
        (mood: "😊", count: 15, percentage: 35.7),
        (mood: "😴", count: 10, percentage: 23.8),
        (mood: "🥰", count: 8, percentage: 19.0),
        (mood: "🤔", count: 5, percentage: 11.9),
        (mood: "😰", count: 4, percentage: 9.5)
    ]
    
    let categories = [
        "😊": "Happy",
        "😴": "Tired",
        "🥰": "Loved",
        "🤔": "Thoughtful",
        "😰": "Anxious"
    ]
    
    return MoodDistributionChart(distribution: sampleDistribution, moodCategories: categories)
        .padding()
}
