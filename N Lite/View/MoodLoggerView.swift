//
//  MoodLoggerView.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import SwiftUI

struct MoodLoggerView: View {
    var body: some View {
        Button(action: { /* do something */ }) {
            Label("Edit", systemImage: "pencil")
                .font(.headline)
                .padding(.horizontal, 18)
                .padding(.vertical, 10)
                .background(.secondaryColorCustom)
                .clipShape(Capsule())
                .foregroundColor(.textColorCustom)
            
            
        }
        Button(action: { /* add mood */ }) {
            Text("Add Mood")
                .fontWeight(.bold)
                .frame(width:200)
                .padding()
                .background(
                    LinearGradient(
                        colors: [.secondaryColorCustom, .green],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .foregroundColor(.white)
                .cornerRadius(12)
        }

    }
}

#Preview {
    MoodLoggerView()
}
