//
//  TodaysMoodCardView.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 5. 11. 2025..
//

import SwiftUI

struct TodaysMoodCardView: View {
    let todaysMood: MoodModel?
    let moodCategories : [String: String]
    
    var body: some View {
        VStack (spacing: 12){
            HStack {
                Image(systemName : "checkmark.circle.fill")
                    .foregroundStyle(Color.primaryColorCustom)
                    .font(.title2)
                Text ("Today's mood already logged")
                    .font(.system(size:16 , weight : .semibold , design: .rounded))
                    .foregroundStyle(.primary)
                
                Spacer()
            }
            if let mood = todaysMood {
                moodDetailRow(for:mood)
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(.ultraThinMaterial)
            .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 4))
        
        
        
    }
    
    private func moodDetailRow(for mood: MoodModel) -> some View {
        HStack{
            Text(mood.mood)
                .font(.system(size:30))
            
            VStack(alignment: .leading, spacing: 4){
                Text(moodCategories[mood.mood] ?? "")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                Text(mood.note)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                
            }
            Spacer()
            
            Text(mood.date.formatted(date: .omitted , time: .shortened))
                .font(.caption)
                .foregroundStyle(.tertiary)
            
        }
        .padding( .vertical ,8)
        .padding(.horizontal , 12)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.primaryColorCustom.opacity(0.1))
        )
    }
}

#Preview {
    TodaysMoodCardView( todaysMood: MoodModel(mood: "😊", note: "Feeling great today!"),
                        moodCategories: ["😊": "Happy"])
    .padding()
}
