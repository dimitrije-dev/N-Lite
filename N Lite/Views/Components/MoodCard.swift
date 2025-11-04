//
//  MoodCard.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import SwiftUI


struct MoodCard: View {
    let entry: MoodModel
    
    @State private var isPressed = false
    
    var body: some View {
        
        VStack(alignment: .leading , spacing: 12){
            HStack{
                ZStack{
                    Circle()
                        .fill(
                            LinearGradient(colors: [Color.primaryColorCustom.opacity(0.3), Color.secondaryColorCustom.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing
                                          )
                        )
                        .frame(width: 50, height: 50)
                    Text(entry.mood)
                        .font(.system(size:28))
                }
                
                VStack(alignment: .leading , spacing: 4){
                    Text(getMoodCategory(for: entry.mood))
                        .font(.system(size:16 , weight: .semibold ,design: .rounded))
                        .foregroundStyle(.textColorCustom)
                    
                    Text(formatDate(entry.date))
                        .font(.system(size:12 , weight: .regular ,design: .rounded))
                        .foregroundStyle(.secondary)
                    
                }
                Spacer()
                
                Text(entry.date.formatted(date:.omitted ,time: .shortened))
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                    .padding(.horizontal , 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.primaryColorCustom.opacity(0.1))
                    )
            }
            
            if !entry.mood.isEmpty && entry.note != "No note"{
                Text(entry.note)
                    .font(Font.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundStyle(.primary.opacity(0.9))
                    .lineLimit(3)
                    .multilineTextAlignment(TextAlignment.leading)
                    .padding(.top , 4)
                
            }
            
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20 , style: .continuous)
                .fill(
                    LinearGradient(colors: [
                        Color.white.opacity(0.9),
                        Color.white.opacity(0.7)
                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .background(
                    RoundedRectangle(cornerRadius: 20 , style: .continuous)
                        .fill(.ultraThinMaterial)
                )
                .shadow(color: Color.black.opacity(0.1), radius: isPressed ? 2 : 10 , x:0 , y : isPressed ? 1 : 5
                        
                       )
            
        )
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .onTapGesture {
            withAnimation(.spring(response : 0.3 ,dampingFraction: 0.7)){
                isPressed.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                withAnimation(.spring(response: 0.3 , dampingFraction: 0.7)){
                    isPressed = false
                }
            }
            
        }
    }
    
    
    private func getMoodCategory(for mood : String) -> String{
        let categories : [String:String] = [
            "😊": "Happy",
            "😔": "Sad",
            "😴": "Tired",
            "😰": "Anxious",
            "😡": "Angry",
            "🥰": "Loved",
            "😎": "Confident",
            "🤔": "Thoughtful"
        ]
        
        return categories[mood] ?? "Unknown"
    }
    
    private func formatDate(_ date: Date) -> String {
        let calendar = Calendar.current
        let now = Date()
        
        if calendar.isDateInToday(date) {
            return "Today"
        }else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        }else if calendar.isDate(date , equalTo: now , toGranularity: .weekOfYear){
            return date.formatted(.dateTime.weekday(.wide))
        }else{
            return date.formatted(date: .abbreviated , time: .omitted)
        }
    }
}
#Preview {
    MoodCard(entry: MoodModel(
        mood: "😊",
        date: Date(),
        note: "Had a great day today! Went for a walk in the park and enjoyed the sunshine."
    )
    )
}

