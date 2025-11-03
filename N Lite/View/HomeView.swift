//
//  HomeVIew.swift
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
        ScrollView{
            
            VStack(spacing: 0){
                
                
                headerSection
                    .padding(.top,40)
                
                quoteCard
                    .padding(.horizontal)
                    .padding(.top, -20)
                
                
                
                VStack(spacing:16){
                    sectionTitle
                    VerticalListView(selectedTab: $selectedTab)
                }.padding(.top, 20)
                .opacity(animateCards ? 1 : 0)
                .offset(y: animateCards ? 0 : 20)
                .animation(.easeOut(duration: 0.6).delay(0.4), value: animateCards)
                
            }
           
        }
        .ignoresSafeArea(edges: .top)
        .onAppear{
            withAnimation(.easeOut(duration: 0.8)){
                animateGreeting = true
            }
            withAnimation(.easeOut(duration: 0.8).delay(0.2)){
                animateQuote = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                animateCards = true
            }
        }
    }
    
    
    
    private var headerSection : some View {
        ZStack{
            LinearGradient(colors: [
                Color(.secondaryColorCustom).opacity(0.9),
                Color(.secondaryColorCustom).opacity(0.2)
            ],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing
            )
            .frame(height: 220)
            .clipShape(RoundedRectangle(cornerRadius: 35 , style: .continuous))
            .ignoresSafeArea(edges:.top)
            
            VStack(spacing: 8){
                Text(homeViewModel.greeting)
                    .font(.system(size: 38, weight: .bold, design: .rounded))
                    .foregroundStyle(.textColorCustom)
                    .opacity(animateGreeting ? 1 : 0)
                    .scaleEffect(animateGreeting ? 1 : 0.8)
                
                Text("Welcome back!")
                    .font(.system(size:18, weight: .medium, design: .rounded))
                    .foregroundStyle(.textColorCustom.opacity(0.9))
                    .opacity(animateGreeting ? 1 : 0 )
            }
            .padding(.top ,50)
            
            
            
        }
    }
    
    private var quoteCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "quote.opening")
                    .font(.title2)
                    .foregroundStyle(Color(.secondaryColorCustom))
                
                Spacer()
                
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        homeViewModel.updateQuote()
                    }
                }) {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .font(.title2)
                        .foregroundStyle(Color(.secondaryColorCustom).opacity(0.8))
                }
            }
            
            Text(homeViewModel.motivationalQuote)
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .transition(.push(from: .bottom).combined(with: .opacity))
                .id(homeViewModel.motivationalQuote) // Force animation on change
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 5)
        )
        .opacity(animateQuote ? 1 : 0)
        .offset(y: animateQuote ? 0 : 20)
    }
    
    private var sectionTitle: some View {
        HStack {
            Text("Quick Actions")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .foregroundStyle(.primary)
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    
}





#Preview {
    HomeView(selectedTab: .constant(0))
}
