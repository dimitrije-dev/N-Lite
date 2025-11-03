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
        VStack {
            CardComponent(title: "New Log", descrription: "How do you feel today? ", iconImage: "pencil.line")
                .onTapGesture {
                    selectedTab = 1  // Switch to Log tab
                }
            
            CardComponent(title: "Progress", descrription: "See how much you have done", iconImage: "chart.pie.fill")
                .onTapGesture {
                    selectedTab = 2  // Switch to Log tab (or create a Progress tab)
                }
            
            CardComponent(title: "Settings", descrription: "Change your preferences", iconImage: "gear.circle")
                .onTapGesture {
                    selectedTab = 3  // Switch to Settings tab
                }
        }
        .padding()
    }
}

#Preview {
    VerticalListView(selectedTab: .constant(0))
}
