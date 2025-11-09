//
//  ProgressView.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import SwiftUI
import SwiftData

struct ProgressView: View {
    @Query(sort: \MoodModel.date, order: .reverse) private var moodEntries: [MoodModel]
    @State private var viewModel = ProgressViewModel()
    @State private var animateStats = false
    @State private var animateCharts = false
    
    private let moodCategories = [
        "😊": "Happy",
        "😔": "Sad",
        "😴": "Tired",
        "😰": "Anxious",
        "😡": "Angry",
        "🥰": "Loved",
        "😎": "Confident",
        "🤔": "Thoughtful"
    ]
    
    var body: some View {
        ZStack {
            Color.backgroundColorCustom.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    headerSection
                        .padding(.top, 20)
                    
                    if moodEntries.isEmpty {
                        emptyState
                    } else {
                        // Stats Grid
                        statsGrid
                            .opacity(animateStats ? 1 : 0)
                            .offset(y: animateStats ? 0 : 20)
                        
                        // Weekly Overview
                        WeeklyOverview(weekData: viewModel.getWeeklyMoodData(entries: moodEntries))
                            .padding(.horizontal)
                            .opacity(animateCharts ? 1 : 0)
                            .offset(y: animateCharts ? 0 : 20)
                        
                        // Mood Distribution
                        MoodDistributionChart(
                            distribution: viewModel.getMoodDistribution(entries: moodEntries),
                            moodCategories: moodCategories
                        )
                        .padding(.horizontal)
                        .opacity(animateCharts ? 1 : 0)
                        .offset(y: animateCharts ? 0 : 20)
                        
                        // Additional Stats
                        additionalStats
                            .opacity(animateCharts ? 1 : 0)
                            .offset(y: animateCharts ? 0 : 20)
                    }
                }
                .padding(.bottom, 100)
            }
        }
        .navigationTitle("Progress")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            animateViews()
        }
    }
    
    // MARK: - Header Section
    
    private var headerSection: some View {
        VStack(spacing: 8) {
            Text("Your Journey")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.primaryColorCustom, Color.secondaryColorCustom],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
            Text("Track your emotional wellness over time")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal)
    }
    
    // MARK: - Stats Grid
    
    private var statsGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            StatCard(
                icon: "flame.fill",
                title: "Current Streak",
                value: "\(viewModel.getCurrentStreak(entries: moodEntries))",
                subtitle: "days",
                gradientColors: [Color.orange, Color.red]
            )
            
            StatCard(
                icon: "chart.line.uptrend.xyaxis",
                title: "Total Entries",
                value: "\(moodEntries.count)",
                subtitle: nil,
                gradientColors: [Color.primaryColorCustom, Color.secondaryColorCustom]
            )
            
            StatCard(
                icon: "trophy.fill",
                title: "Longest Streak",
                value: "\(viewModel.getLongestStreak(entries: moodEntries))",
                subtitle: "days",
                gradientColors: [Color.yellow, Color.orange]
            )
            
            StatCard(
                icon: "calendar",
                title: "Avg per Week",
                value: String(format: "%.1f", viewModel.getAverageMoodsPerWeek(entries: moodEntries)),
                subtitle: "entries",
                gradientColors: [Color.blue, Color.purple]
            )
        }
        .padding(.horizontal)
    }
    
    // MARK: - Additional Stats
    
    private var additionalStats: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Insights")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundStyle(.primary)
            
            VStack(spacing: 12) {
                insightRow(
                    icon: "star.fill",
                    title: "Most Common Mood",
                    value: viewModel.getMostCommonMood(entries: moodEntries) ?? "N/A"
                )
                
                insightRow(
                    icon: "clock.fill",
                    title: "Tracking Since",
                    value: viewModel.getTimeRange(entries: moodEntries)
                )
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 4)
        )
        .padding(.horizontal)
    }
    
    private func insightRow(icon: String, title: String, value: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundStyle(Color.primaryColorCustom)
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(.secondary)
                
                Text(value)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
            }
            
            Spacer()
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.primaryColorCustom.opacity(0.05))
        )
    }
    
    // MARK: - Empty State
    
    private var emptyState: some View {
        VStack(spacing: 20) {
            Image(systemName: "chart.bar.fill")
                .font(.system(size: 60))
                .foregroundStyle(Color.primaryColorCustom.opacity(0.3))
            
            Text("No Data Yet")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)
            
            Text("Start logging your moods to see your progress and insights here")
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity)
        .padding(40)
    }
    
    // MARK: - Animations
    
    private func animateViews() {
        withAnimation(.easeOut(duration: 0.5)) {
            animateStats = true
        }
        withAnimation(.easeOut(duration: 0.5).delay(0.2)) {
            animateCharts = true
        }
    }
}

#Preview {
    NavigationStack {
        ProgressView()
            .modelContainer(for: MoodModel.self, inMemory: true)
    }
}
