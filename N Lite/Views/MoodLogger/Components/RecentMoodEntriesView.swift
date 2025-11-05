//
//  RecentMoodEntriesView.swift
//  N Lite
//

import SwiftUI

struct RecentMoodEntriesView: View {
    @Bindable var viewModel: MoodViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            header
            
            if !viewModel.moodEntries.isEmpty {
                entriesList
            } else {
                emptyState
            }
        }
    }
    
    private var header: some View {
        HStack {
            Text("Recent Entries")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .foregroundStyle(.primary)
            
            Spacer()
            
            Text("\(viewModel.moodEntries.count) total")
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(.secondary)
        }
    }
    
    private var entriesList: some View {
        ForEach(viewModel.moodEntries.sorted { $0.date > $1.date }.prefix(3)) { entry in
            MoodEntryRow(entry: entry) {
                withAnimation {
                    viewModel.deleteMoodEntry(entry)
                }
            }
        }
    }
    
    private var emptyState: some View {
        Text("No entries yet. Start tracking your mood!")
            .font(.system(size: 14, weight: .regular, design: .rounded))
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.primaryColorCustom.opacity(0.05))
            )
    }
}

struct MoodEntryRow: View {
    let entry: MoodModel
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Text(entry.mood)
                .font(.system(size: 30))
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.note)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                
                Text(entry.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .font(.system(size: 14))
                    .foregroundStyle(.red.opacity(0.7))
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.primaryColorCustom.opacity(0.05))
        )
    }
}

#Preview {
    RecentMoodEntriesView(viewModel: MoodViewModel())
        .padding()
}
