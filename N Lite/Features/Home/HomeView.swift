//
//  HomeView.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: Int
    
    var homeViewModel = HomeViewModel()
    
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
            animateViewComponents()
        }
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
}
