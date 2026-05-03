//
//  HomeHeaderView.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 6. 11. 2025..
//

import SwiftUI

struct HomeHeaderView: View {
    let greeting: String
    let subGreeting: String
    let dateLabel: String
    let isAnimated: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // Gradient background - extends to absolute top
                LinearGradient(
                    colors: [
                        Color.primaryColorCustom.opacity(0.9),
                        Color.cyan.opacity(0.4)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea(edges: .top) // ← KEY: Goes behind notch/Dynamic Island
                
                // Content with safe area respect
                VStack(spacing: 8) {
                    HStack(spacing: 8) {
                        Image("LogoNLite")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .shadow(color: Color.black.opacity(0.08), radius: 2, x: 0, y: 1)
                        
                        Text(dateLabel.uppercased())
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                            .tracking(1.2)
                            .foregroundStyle(.textColorCustom.opacity(0.82))
                    }
                    .opacity(isAnimated ? 1 : 0)
                    .offset(y: isAnimated ? 0 : -8)
                    
                    Text(greeting)
                        .font(.system(size: 38, weight: .bold, design: .rounded))
                        .foregroundStyle(.textColorCustom)
                        .opacity(isAnimated ? 1 : 0)
                        .scaleEffect(isAnimated ? 1 : 0.8)
                    
                    Text(subGreeting)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundStyle(.textColorCustom.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 28)
                        .opacity(isAnimated ? 1 : 0)
                }
                .padding(.top, geometry.safeAreaInsets.top + 56)
                .frame(maxWidth: .infinity)
            }
        }
        .frame(height: 250)
        .clipShape(RoundedRectangle(cornerRadius: 35, style: .continuous))
    }
}

#Preview {
    ZStack {
        Color.backgroundColorCustom
        HomeHeaderView(
            greeting: "Good morning",
            subGreeting: "A calm start builds momentum for the whole day.",
            dateLabel: "Monday, May 3",
            isAnimated: true
        )
    }
    .ignoresSafeArea()
}
