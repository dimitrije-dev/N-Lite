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
    @State private var animateLogo = false
    @State private var animateText = false
    @State private var pulseGlow = false
    
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
            
            Circle()
                .stroke(Color.primaryColorCustom.opacity(0.16), lineWidth: 2)
                .frame(width: 250, height: 250)
                .scaleEffect(pulseGlow ? 1.08 : 0.9)
                .opacity(pulseGlow ? 0.25 : 0.6)
            
            VStack(spacing: 18) {
                Image("LogoNLite")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170, height: 170)
                    .scaleEffect(animateLogo ? 1 : 0.72)
                    .opacity(animateLogo ? 1 : 0)
                    .shadow(color: Color.primaryColorCustom.opacity(0.35), radius: 24, x: 0, y: 10)
                
                VStack(spacing: 6) {
                    Text("N Lite")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.primaryColorCustom, Color.secondaryColorCustom],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                    Text("Mindful moments, every day")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(.secondary)
                }
                .opacity(animateText ? 1 : 0)
                .offset(y: animateText ? 0 : 10)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.75)) {
                animateLogo = true
            }
            withAnimation(.easeOut(duration: 0.55).delay(0.2)) {
                animateText = true
            }
            withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
                pulseGlow = true
            }
        }
    }
}

#Preview {
    ContentView()
}
