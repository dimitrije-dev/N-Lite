//
//  MoodSelectionView.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 5. 11. 2025..
//

import SwiftUI

struct MoodSelectionView: View {
    @Bindable var viewModel: MoodViewModel
    let animateMoods : Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Select Your Mood")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundStyle(.primary)
            
            moodGrid
            
            if !viewModel.selectedMood.isEmpty {
                selectedMoodLabel
                    .transition(.scale.combined(with: .opacity))
                
            }
            
            
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 4)
        )
    }
    
    
    private var moodGrid: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 16) {
            ForEach(Array(viewModel.availableMoods.enumerated()), id: \.offset) { index, mood in
                MoodButton(mood: mood, isSelected: viewModel.selectedMood == mood) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        viewModel.selectedMood = mood
                    }
                }
                .scaleEffect(animateMoods ? 1 : 0)
            }
        }
    }
    
    private var selectedMoodLabel : some View {
        HStack{
            Text("Selected:")
                .font(.system(size: 14, weight: .medium, design: .rounded))
            Text(viewModel.selectedMood)
                .font(.system(size:20))
            Text(viewModel.moodCategories[viewModel.selectedMood] ?? "")
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.primaryColorCustom)
            
        }
    }
}



#Preview {
    MoodSelectionView(viewModel: MoodViewModel(),
                      animateMoods: true)
}
