//
//  StatCard.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 9. 11. 2025..
//

import SwiftUI

struct StatCard: View {
    let icon : String
    let title : String
    let value : String
    let subtitle: String?
    var gradientColors: [Color] = [Color.primaryColorCustom, Color.secondaryColorCustom]
    
    
    
    
    var body: some View {
        VStack(spacing: 12){
            ZStack{
                Circle()
                    .fill(
                        LinearGradient(colors: gradientColors.map {$0.opacity(0.4)}, startPoint: .topLeading, endPoint: .bottomTrailing)
                        
                    )
                    .frame(width: 50 , height: 50)
                
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(
                        LinearGradient(
                            colors: gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                
            }
            
            Text(title)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(.secondary)
            
            
            Text(value)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.tertiary)
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 4)
        )
        
    }
}


#Preview {
    HStack(spacing: 12) {
        StatCard(
            icon: "flame.fill",
            title: "Current Streak",
            value: "7",
            subtitle: "days"
        )
        
        StatCard(
            icon: "chart.line.uptrend.xyaxis",
            title: "Total Entries",
            value: "42",
            subtitle: nil,
            gradientColors: [Color.blue, Color.purple]
        )
    }
    .padding()
}
