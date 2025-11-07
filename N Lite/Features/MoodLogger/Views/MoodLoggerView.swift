//
//  MoodLoggerView.swift
//  N Lite
//

import SwiftUI
import SwiftData

struct MoodLoggerView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \MoodModel.date, order: .reverse) private var moodEntries: [MoodModel]
    
    @State private var moodViewModel = MoodViewModel()
    @State private var showingSaveAlert = false
    @State private var animateMoods = false
    @State private var animateForm = false
    
    @FocusState private var isNoteFocused: Bool
    
    var body: some View {
        ZStack {
            // Background with tap gesture to dismiss keyboard
            Color.backgroundColorCustom
                .ignoresSafeArea()
                .onTapGesture {
                    isNoteFocused = false
                }
            
            ScrollViewReader { scrollProxy in
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        MoodLoggerHeaderView()
                            .padding(.top, 20)
                        
                        // Today's Status Card
                        if moodViewModel.hasEnteredMoodToday(entries: moodEntries) {
                            TodaysMoodCardView(
                                todaysMood: moodViewModel.getTodaysMood(entries: moodEntries),
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
                        
                        // Note Input with ID for scrolling
                        NoteInputView(
                            moodNote: $moodViewModel.moodNote,
                            isNoteFocused: $isNoteFocused
                        )
                        .padding(.horizontal)
                        .opacity(animateForm ? 1 : 0)
                        .offset(y: animateForm ? 0 : 20)
                        .id("noteInput")
                        .onChange(of: isNoteFocused) { oldValue, newValue in
                            if newValue {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        scrollProxy.scrollTo("noteInput", anchor: .center)
                                    }
                                }
                            }
                        }
                        
                        // Save Button
                        SaveMoodButton(
                            isEnabled: !moodViewModel.selectedMood.isEmpty,
                            action: saveMood
                        )
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                        
                        // Recent Entries
                        RecentMoodEntriesView(
                            entries: Array(moodEntries.prefix(5)),
                            onDelete: { entry in
                                withAnimation {
                                    moodViewModel.deleteMoodEntry(entry)
                                }
                            }
                        )
                        .padding(.horizontal)
                        .padding(.bottom, 100)
                    }
                }
                .scrollDismissesKeyboard(.interactively)
            }
        }
        .navigationTitle("Mood Logger")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            moodViewModel.modelContext = modelContext
            animateViews()
        }
        .alert("Mood Saved!", isPresented: $showingSaveAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Your mood has been logged successfully!")
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isNoteFocused = false
                }
            }
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
            .modelContainer(for: MoodModel.self, inMemory: true)
    }
}
