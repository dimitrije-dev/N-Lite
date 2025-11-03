//
//  MoodCard.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import SwiftUI


struct MoodCard: View {
    let entry: MoodModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(entry.mood)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Text(entry.date.formatted(date: .numeric, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Text(entry.note)
                .font(.body)
                .foregroundStyle(Color(.textColorCustom))
        }
        .padding()
        .background(
            LinearGradient(colors: [Color.primaryColorCustom, Color.secondaryColorCustom], startPoint: .topLeading, endPoint: .bottom)
        )
        .cornerRadius(16)
        .shadow(radius: 10)
    }
}
#Preview {
    let calendar = Calendar.current
    
    var components = DateComponents()
    components.year = 2025
    components.month = 11
    components.day = 3
    components.hour = 15
    components.minute = 30
    
    let testDate = calendar.date(from: components) ?? Date()
    
    return MoodCard(entry: MoodModel(mood: "Happy", date: testDate, note: "Happy"))
    
}

