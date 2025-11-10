//
//  SettingsSectionHeader.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 10. 11. 2025..
//

import SwiftUI

struct SettingsSectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 18, weight: .semibold, design: .rounded))
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 4)
            .padding(.top, 8)
    }
}

#Preview {
    SettingsSectionHeader(title: "General")
}
