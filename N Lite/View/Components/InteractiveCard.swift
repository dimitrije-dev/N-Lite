//
//  InteracitveCardComponent.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 4. 11. 2025..
//

import SwiftUI

struct InteractiveCard: View {
    let title: String
    let description : String
    let iconImage: String
    var gradientColors : [Color] = [.red, .blue]
    let action : () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        CardComponent(title: title, description: description, iconImage: iconImage, gradientColors: gradientColors, isPressed: isPressed)
            .scaleEffect(isPressed ? 0.98 : 1.0)
            .onTapGesture {
                withAnimation(.spring(response:0.3 , dampingFraction: 0.7)){
                    isPressed = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    action()
                    
                    
                    withAnimation(.spring(response: 0.3 , dampingFraction:0.7)){
                        isPressed = false
                    }
                }
            }
    }
}

#Preview {
    InteractiveCard(title: "Glassmorphism Card", description: "Beautiful frosted glass effect" , iconImage: "person.crop.circle", action: {})
}
