//
//  SectionHeaderView.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 6. 11. 2025..
//

import SwiftUI

struct SectionHeaderView: View {
    let title: String
    var subtitle: String? = nil
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    VStack(spacing: 20) {
        SectionHeaderView(title: "Quick Actions")
        SectionHeaderView(
            title: "Quick Actions",
            subtitle: "Navigate to your favorite features"
        )
    }
}
