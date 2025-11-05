//
//  MoodButton.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 5. 11. 2025..
//

import SwiftUI

struct MoodButton: View {
    let mood :String
    let isSelected : Bool
    let action : () -> Void
    
    var body: some View {
        Button(action: action){
            Text(mood)
                .font(.system(size: 40 ))
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .background(
                    RoundedRectangle(cornerRadius: 16, style:  .continuous)
                        .fill(isSelected ? Color.primaryColorCustom.opacity(0.2) : Color.primaryColorCustom.opacity(0.05))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16 , style: .continuous)
                                .stroke(isSelected ? Color.primaryColorCustom : Color.clear , lineWidth: 2
                                       )
                        )
                )
            
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack {
        MoodButton(mood: "😊", isSelected: false) { }
        MoodButton(mood: "😔", isSelected: true) { }
    }
    .padding(16)
}
