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
        ZStack {
                    LinearGradient(
                        colors: [
                            Color.primaryColorCustom.opacity(0.9),
                            Color.cyan.opacity(0.4)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 35, style: .continuous))
                    .ignoresSafeArea(edges: .top)
                    
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
                    .padding(.top, 50)
                }
        
    }
}

#Preview {
    HomeHeaderView(
           greeting: "Good Morning 🌅",
           isAnimated: true
       )
}
