//
//  HomeView.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Binding var selectedTab: Int
    @Query(sort: \MoodModel.date, order: .reverse) private var moodEntries: [MoodModel]
    
    @State private var homeViewModel = HomeViewModel()
    
    @State private var animateGreeting = false
    @State private var animateQuote = false
    @State private var animateCards = false
    
    var body: some View {
        ZStack {
            // Background color extends everywhere
            Color.backgroundColorCustom
                .ignoresSafeArea(edges: .all)
            
            ScrollView {
                VStack(spacing: 0) {
                    // Header - extends behind notch/Dynamic Island
                    HomeHeaderView(
                        greeting: homeViewModel.greeting,
                        subGreeting: homeViewModel.subGreeting,
                        dateLabel: homeViewModel.dateLabel,
                        isAnimated: animateGreeting
                    )
                    
                    // Quote Card - positioned to overlap header
                    QuoteCardView(
                        quote: homeViewModel.motivationalQuote,
                        isAnimated: animateQuote,
                        onRefresh: { homeViewModel.updateQuote() }
                    )
                    .padding(.horizontal)
                    .padding(.top, -40)
                    
                    quickOverview
                        .padding(.horizontal)
                        .padding(.top, 16)
                        .opacity(animateQuote ? 1 : 0)
                        .offset(y: animateQuote ? 0 : 14)
                    
                    // Quick Actions Section
                    VStack(spacing: 16) {
                        SectionHeaderView(title: "Quick Actions")
                        
                        VerticalListView(selectedTab: $selectedTab)
                    }
                    .padding(.top, 20)
                    .opacity(animateCards ? 1 : 0)
                    .offset(y: animateCards ? 0 : 20)
                    .animation(.easeOut(duration: 0.6).delay(0.4), value: animateCards)
                }
            }
            .ignoresSafeArea(edges: .top) // ← Allows content to go under notch
        }
        .onAppear {
            homeViewModel.updateGreeting()
            homeViewModel.updateDateLabel()
            animateViewComponents()
        }
    }
    
    private var quickOverview: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                quickStatCard(
                    title: "Current Streak",
                    value: "\(MoodAnalytics.currentStreak(entries: moodEntries)) days",
                    icon: "flame.fill",
                    color: .orange
                )
                
                quickStatCard(
                    title: "Total Entries",
                    value: "\(moodEntries.count)",
                    icon: "chart.bar.fill",
                    color: .primaryColorCustom
                )
            }
            
            statusCard
        }
    }
    
    private var statusCard: some View {
        let todaysMood = moodEntries.first { Calendar.current.isDateInToday($0.date) }
        
        return HStack(spacing: 12) {
            Image(systemName: todaysMood == nil ? "calendar.badge.plus" : "checkmark.seal.fill")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(todaysMood == nil ? Color.secondaryColorCustom : Color.primaryColorCustom)
                .frame(width: 36, height: 36)
                .background(
                    Circle()
                        .fill((todaysMood == nil ? Color.secondaryColorCustom : Color.primaryColorCustom).opacity(0.15))
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(todaysMood == nil ? "No check-in yet today" : "Today's mood is logged")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                
                Text(todaysMood == nil ? "Take 10 seconds and capture how you feel." : "Great consistency. Keep the streak alive.")
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Button(todaysMood == nil ? "Log now" : "View log") {
                selectedTab = 1
            }
            .font(.system(size: 13, weight: .semibold, design: .rounded))
            .foregroundStyle(Color.textColorCustom)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [Color.primaryColorCustom, Color.secondaryColorCustom],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            )
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
    }
    
    private func quickStatCard(title: String, value: String, icon: String, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(color)
                .frame(width: 34, height: 34)
                .background(
                    RoundedRectangle(cornerRadius: 9, style: .continuous)
                        .fill(color.opacity(0.14))
                )
            
            Text(value)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)
            
            Text(title)
                .font(.system(size: 13, weight: .medium, design: .rounded))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
    }
    
    // MARK: - Private Methods
    
    private func animateViewComponents() {
        withAnimation(.easeOut(duration: 0.8)) {
            animateGreeting = true
        }
        
        withAnimation(.easeOut(duration: 0.8).delay(0.2)) {
            animateQuote = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            animateCards = true
        }
    }
}

#Preview {
    HomeView(selectedTab: .constant(0))
        .modelContainer(for: MoodModel.self, inMemory: true)
}
