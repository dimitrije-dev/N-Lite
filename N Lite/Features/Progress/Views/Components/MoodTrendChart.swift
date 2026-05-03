//
//  MoodTrendChart.swift
//  N Lite
//
//  Created by Codex on 03.05.2026.
//

import SwiftUI
import Charts

struct MoodTrendChart: View {
    let points: [MoodTrendPoint]
    
    private var averageScore: Double {
        let loggedPoints = points.filter(\.didLogMood)
        guard !loggedPoints.isEmpty else { return 0 }
        return loggedPoints.map(\.value).reduce(0, +) / Double(loggedPoints.count)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Two-Week Trend")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                
                Spacer()
                
                Text("\(Int(averageScore.rounded()))/100")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundStyle(.secondary)
            }
            
            if points.contains(where: \.didLogMood) {
                Chart(points) { point in
                    if point.didLogMood {
                        AreaMark(
                            x: .value("Date", point.date),
                            y: .value("Score", point.value)
                        )
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.primaryColorCustom.opacity(0.35), Color.secondaryColorCustom.opacity(0.05)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        
                        LineMark(
                            x: .value("Date", point.date),
                            y: .value("Score", point.value)
                        )
                        .interpolationMethod(.catmullRom)
                        .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.primaryColorCustom, Color.secondaryColorCustom],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        
                        PointMark(
                            x: .value("Date", point.date),
                            y: .value("Score", point.value)
                        )
                        .foregroundStyle(Color.primaryColorCustom)
                    }
                }
                .frame(height: 200)
                .chartYScale(domain: 0...100)
                .chartYAxis {
                    AxisMarks(values: [0, 25, 50, 75, 100]) {
                        AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5))
                            .foregroundStyle(Color.secondary.opacity(0.2))
                    }
                }
                .chartXAxis {
                    AxisMarks(values: .stride(by: .day, count: 3)) { value in
                        AxisValueLabel(format: .dateTime.day().month(.abbreviated))
                    }
                }
            } else {
                Text("Log moods to start seeing your trend line.")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
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
}

#Preview {
    let calendar = Calendar.current
    let now = Date()
    let points = (0..<14).compactMap { offset -> MoodTrendPoint? in
        guard let date = calendar.date(byAdding: .day, value: -offset, to: now) else { return nil }
        return MoodTrendPoint(date: date, value: Double(Int.random(in: 20...95)), didLogMood: true)
    }.reversed()
    
    return MoodTrendChart(points: Array(points))
        .padding()
}
