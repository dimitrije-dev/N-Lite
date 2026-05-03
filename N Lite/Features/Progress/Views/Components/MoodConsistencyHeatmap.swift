//
//  MoodConsistencyHeatmap.swift
//  N Lite
//
//  Created by Codex on 03.05.2026.
//

import SwiftUI

struct MoodConsistencyHeatmap: View {
    let score: Int
    let days: [MoodDayIntensity]
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 5), count: 7)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .firstTextBaseline) {
                Text("Consistency (Last 4 Weeks)")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                
                Spacer()
                
                Text("\(score)%")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.primaryColorCustom)
            }
            
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(days) { day in
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .fill(color(for: day.level))
                        .frame(height: 18)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4, style: .continuous)
                                .stroke(Color.white.opacity(0.35), lineWidth: 0.3)
                        )
                        .accessibilityLabel(day.date.formatted(.dateTime.day().month().year()))
                        .accessibilityValue("\(day.count) entries")
                }
            }
            
            HStack(spacing: 10) {
                Text("Less")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 4) {
                    ForEach(0...4, id: \.self) { level in
                        RoundedRectangle(cornerRadius: 3, style: .continuous)
                            .fill(color(for: level))
                            .frame(width: 14, height: 10)
                    }
                }
                
                Text("More")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 4)
        )
    }
    
    private func color(for level: Int) -> Color {
        switch level {
        case 0:
            return Color.primaryColorCustom.opacity(0.08)
        case 1:
            return Color.primaryColorCustom.opacity(0.25)
        case 2:
            return Color.primaryColorCustom.opacity(0.45)
        case 3:
            return Color.secondaryColorCustom.opacity(0.65)
        default:
            return Color.secondaryColorCustom.opacity(0.9)
        }
    }
}

#Preview {
    let calendar = Calendar.current
    let now = Date()
    let sample = (0..<28).compactMap { offset -> MoodDayIntensity? in
        guard let date = calendar.date(byAdding: .day, value: -offset, to: now) else { return nil }
        let random = Int.random(in: 0...4)
        return MoodDayIntensity(date: date, count: random, level: random)
    }.reversed()
    
    return MoodConsistencyHeatmap(score: 74, days: Array(sample))
        .padding()
}
