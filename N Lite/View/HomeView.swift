//
//  HomeVIew.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        ScrollView{
            
            VStack(spacing: 20){
                Text("Welcome back to")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(Color(.textColorCustom))
                
                Text("N Lite")
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(.secondaryColorCustom))
                
                VerticalListView(selectedTab: $selectedTab)
                    
            }
            .padding()
            .padding(.top, 20)
        }
    }
}

#Preview {
    HomeView(selectedTab: .constant(0))
}
