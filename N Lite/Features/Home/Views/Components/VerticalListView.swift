//
//  HorizontalListVIew.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import SwiftUI

struct VerticalListView: View {
    @Binding var selectedTab: Int
        
    var body: some View {
        VStack(spacing: 14) {
            InteractiveCard(
                title: "New Log",
                description: "Capture today's mood in under 10 seconds",
                iconImage: "pencil.line",
                gradientColors: [Color.primaryColorCustom.opacity(0.8), Color.cyan.opacity(0.6)],
                action: {
                    selectedTab = 1
                }
                
            )
        
            
            
            InteractiveCard(
                title: "Progress",
                description: "Review trends, consistency, and mood balance",
                iconImage: "chart.pie.fill",
                gradientColors: [Color.secondaryColorCustom.opacity(0.8), Color.cyan.opacity(0.6)],
                action: {
                    selectedTab = 2
                }
            )
           
            
            
            InteractiveCard(
                title: "Settings",
                description: "Manage reminders, privacy, and app preferences",
                iconImage: "gear.circle",
                gradientColors: [Color.primaryColorCustom.opacity(0.8), Color.blue.opacity(0.6)],
                action: {
                    selectedTab = 3
                }
            )
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    VerticalListView(selectedTab: .constant(0))
}
