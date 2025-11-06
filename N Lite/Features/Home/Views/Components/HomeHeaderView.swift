//
//  HomeHeaderView.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 6. 11. 2025..
//

import SwiftUI

struct HomeHeaderView: View {
    let greeting: String
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
                    Text(greeting)
                        .font(.system(size: 38, weight: .bold, design: .rounded))
                        .foregroundStyle(.textColorCustom)
                        .opacity(isAnimated ? 1 : 0)
                        .scaleEffect(isAnimated ? 1 : 0.8)
                    
                    Text("Welcome back!")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundStyle(.textColorCustom.opacity(0.9))
                        .opacity(isAnimated ? 1 : 0)
                }
                .padding(.top, geometry.safeAreaInsets.top + 70) // ← Accounts for notch/island
                .frame(maxWidth: .infinity)
            }
        }
        .frame(height: 220)
        .clipShape(RoundedRectangle(cornerRadius: 35, style: .continuous))
    }
}

#Preview {
    ZStack {
        Color.backgroundColorCustom
        HomeHeaderView(
            greeting: "Good Morning 🌅",
            isAnimated: true
        )
    }
    .ignoresSafeArea()
}
