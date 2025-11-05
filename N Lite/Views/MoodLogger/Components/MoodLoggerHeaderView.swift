//
//  MoodLoggerHeaderView.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 5. 11. 2025..
//

import SwiftUI

struct MoodLoggerHeaderView: View {
    var body: some View {
        VStack (spacing: 8){
            
            Text("How are you feeling?")
                .font(.system(size:32 , weight: .bold , design: .rounded))
                .foregroundStyle(Color.primaryColorCustom)
            
            Text("Take a moment to reflect on your emotions")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal)
    }
}

#Preview {
    MoodLoggerHeaderView()
}
