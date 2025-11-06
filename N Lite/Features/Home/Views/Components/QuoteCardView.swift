//
//  QuoteCardView.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 6. 11. 2025..
//

import SwiftUI

struct QuoteCardView: View {
    let quote: String
    let isAnimated: Bool
    let onRefresh: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "quote.opening")
                    .font(.title2)
                    .foregroundStyle(Color.secondaryColorCustom)
                
                Spacer()
                
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        onRefresh()
                    }
                }) {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .font(.title2)
                        .foregroundStyle(Color.secondaryColorCustom.opacity(0.8))
                }
            }
            
            Text(quote)
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .transition(.push(from: .bottom).combined(with: .opacity))
                .id(quote) // Force animation on change
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: Color.black.opacity(0.09), radius: 10, x: 0, y: 5)
        )
        .opacity(isAnimated ? 1 : 0)
        .offset(y: isAnimated ? 0 : 20)
    }
}

#Preview {
    QuoteCardView(
        quote: "Every day is a fresh start.",
        isAnimated: true,
        onRefresh: {}
    )
    .padding()
}
