//
//  ContentView.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var showSplash = true
    
    var body: some View {
        ZStack {
            if showSplash {
                SplashScreenView()
                    .transition(.opacity.combined(with: .scale(scale: 1.03)))
            } else {
                mainTabView
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.45), value: showSplash)
        .task {
            guard showSplash else { return }
            try? await Task.sleep(for: .seconds(2.2))
            withAnimation {
                showSplash = false
            }
        }
    }
    
    private var mainTabView: some View {
        ZStack {
            Color.backgroundColorCustom.ignoresSafeArea(edges: .all)
            TabView(selection: $selectedTab) {
                Tab("Home", systemImage: "house", value: 0) {
                    NavigationStack {
                        HomeView(selectedTab: $selectedTab)
                    }
                }
                Tab("Log", systemImage: "face.smiling", value: 1) {
                    NavigationStack {
                        MoodLoggerView()
                    }
                }
                Tab("Progress", systemImage: "chart.pie.fill", value: 2) {
                    NavigationStack {
                        ProgressView()
                    }
                }
                Tab("Settings", systemImage: "gear", value: 3) {
                    NavigationStack {
                        SettingsView()
                    }
                }
            }
        }
    }
}

private struct SplashScreenView: View {
    @State private var animateCore = false
    @State private var animateText = false
    @State private var pulseRing = false
    @State private var rotateArc = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.backgroundColorCustom,
                    Color.primaryColorCustom.opacity(0.18),
                    Color.secondaryColorCustom.opacity(0.14)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ZStack {
                Circle()
                    .stroke(Color.primaryColorCustom.opacity(0.22), lineWidth: 1.2)
                    .frame(width: 215, height: 215)
                    .scaleEffect(pulseRing ? 1.05 : 0.9)
                    .opacity(pulseRing ? 0.2 : 0.55)
                
                Circle()
                    .trim(from: 0.08, to: 0.82)
                    .stroke(
                        LinearGradient(
                            colors: [Color.primaryColorCustom, Color.secondaryColorCustom],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        style: StrokeStyle(lineWidth: 6, lineCap: .round)
                    )
                    .frame(width: 160, height: 160)
                    .rotationEffect(.degrees(rotateArc ? 360 : 0))
                
                Image("LogoNLite")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 92, height: 92)
                    .scaleEffect(animateCore ? 1 : 0.82)
                    .opacity(animateCore ? 1 : 0)
                    .shadow(color: Color.primaryColorCustom.opacity(0.3), radius: 18, x: 0, y: 8)
                
                HStack(alignment: .bottom, spacing: 8) {
                    ForEach(0..<4, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [Color.primaryColorCustom, Color.secondaryColorCustom],
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                            )
                            .frame(width: 10, height: animateCore ? CGFloat(18 + (index * 8)) : 8)
                            .opacity(0.88)
                            .animation(
                                .easeInOut(duration: 0.55).delay(Double(index) * 0.08),
                                value: animateCore
                            )
                    }
                }
                .offset(y: 73)
                
                Image(systemName: "sparkles")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.secondaryColorCustom.opacity(0.85))
                    .offset(x: 0, y: -54)
                    .opacity(animateCore ? 1 : 0)
            }
            
            VStack(spacing: 6) {
                Spacer()
                
                Text("N Lite")
                    .font(.system(size: 38, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.primaryColorCustom, Color.secondaryColorCustom],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                Text("Track your mood. See your momentum.")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 100)
            }
            .opacity(animateText ? 1 : 0)
            .offset(y: animateText ? 0 : 10)
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.75)) {
                animateCore = true
            }
            withAnimation(.easeOut(duration: 0.55).delay(0.18)) {
                animateText = true
            }
            withAnimation(.easeInOut(duration: 1.3).repeatForever(autoreverses: true)) {
                pulseRing = true
            }
            withAnimation(.linear(duration: 4.2).repeatForever(autoreverses: false)) {
                rotateArc = true
            }
        }
    }
}

#Preview {
    ContentView()
}
