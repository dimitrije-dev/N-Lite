//
//  MoodLoggerView.swift
//  N Lite
//

import SwiftUI

struct MoodLoggerView: View {
    @State private var moodViewModel = MoodViewModel()
    @State private var showingSaveAlert = false
    @State private var animateMoods = false
    @State private var animateForm = false
    
    @FocusState private var isNoteFocused: Bool
    
    var body: some View {
        ZStack {
            Color.backgroundColorCustom.ignoresSafeArea()
                .onTapGesture {
                    isNoteFocused = false
                }
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    MoodLoggerHeaderView()
                        .padding(.top, 20)
                    
                    // Today's Status Card
                    if moodViewModel.hasEnteredMoodToday {
                        TodaysMoodCardView(
                            todaysMood: moodViewModel.getTodaysMood(),
                            moodCategories: moodViewModel.moodCategories
                        )
                        .padding(.horizontal)
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }
                    
                    // Mood Selection
                    MoodSelectionView(
                        viewModel: moodViewModel,
                        animateMoods: animateMoods
                    )
                    .padding(.horizontal)
                    .opacity(animateMoods ? 1 : 0)
                    .offset(y: animateMoods ? 0 : 20)
                    
                    // Note Input
                    NoteInputView(
                        moodNote: $moodViewModel.moodNote,
                        isNoteFocused: $isNoteFocused
                    )
                    .padding(.horizontal)
                    .opacity(animateForm ? 1 : 0)
                    .offset(y: animateForm ? 0 : 20)
                    
                    // Save Button
                    SaveMoodButton(
                        isEnabled: !moodViewModel.selectedMood.isEmpty,
                        action: saveMood
                    )
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                    
                    // Recent Entries
                    RecentMoodEntriesView(viewModel: moodViewModel)
                        .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Mood Logger")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: animateViews)
        .alert("Mood Saved!", isPresented: $showingSaveAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Your mood has been logged successfully!")
        }
        
    }
    
    private func animateViews() {
        withAnimation(.easeOut(duration: 0.5)) {
            animateMoods = true
        }
        withAnimation(.easeOut(duration: 0.5).delay(0.2)) {
            animateForm = true
        }
    }
    
    private func saveMood() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            moodViewModel.saveMoodEntry()
            showingSaveAlert = true
            isNoteFocused = false
        }
    }
}

#Preview {
    NavigationStack {
        MoodLoggerView()
    }
}
