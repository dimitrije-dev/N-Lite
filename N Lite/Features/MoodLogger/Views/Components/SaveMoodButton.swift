//
//  SaveButton.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 4. 11. 2025..
//

import SwiftUI

struct SaveMoodButton: View {
    
    let isEnabled: Bool
    let action : () -> Void
    
    var body: some View {
        
        Button(action:action) {
            HStack{
                Image(systemName: "checkmark.circle.fill")
                    .font(.title3)
                
                Text("Save Mood")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical , 16)
            .background(
                LinearGradient(
                    colors: isEnabled
                    ? [Color.primaryColorCustom, Color.secondaryColorCustom]
                    : [Color.gray.opacity(0.5), Color.gray.opacity(0.3)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(16)
            .shadow(
                color: isEnabled ? Color.primaryColorCustom.opacity(0.3) : Color.clear,
                radius: 10,
                x: 0,
                y: 5
            )
            .disabled(!isEnabled)
            .scaleEffect(isEnabled ? 1.0 : 0.95)
            .animation(.spring(response: 0.3), value: isEnabled)
            
            
            
        }
        
    }
}

#Preview {
    VStack {
        SaveMoodButton(isEnabled: true) { }
        SaveMoodButton(isEnabled: false) { }
    }
    .padding()
}
