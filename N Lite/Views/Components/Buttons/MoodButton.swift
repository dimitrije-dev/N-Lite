//
//  MoodButton.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import SwiftUI

struct MoodButton: View {
    let mood: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action){
            Text(mood)
                .font(.system(size: 40))
                .scaleEffect(isSelected ? 1.2 : 1.0)
                .frame(width: 60, height: 60)
                .background(
                    Circle()
                        .fill(isSelected ? Color.primaryColorCustom.opacity(0.2) : Color.clear)
                        .overlay(
                            Circle()
                                .stroke(isSelected ? Color.primaryColorCustom : Color.clear, lineWidth: 2)
                        )
                )
                .animation(.spring(response:0.3) , value: isSelected)
            
        }
        
    }
}

#Preview {
    MoodButton(mood: "😊", isSelected: false, action: {})
}
