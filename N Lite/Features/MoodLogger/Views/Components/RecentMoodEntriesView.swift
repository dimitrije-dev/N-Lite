//
//  RecentMoodEntriesView.swift
//  N Lite
//

import SwiftUI

struct RecentMoodEntriesView: View {
    let entries: [MoodModel]
    let onDelete: (MoodModel) -> Void
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            header
            
            if !entries.isEmpty == false {
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
            
            Text("\(entries.count) shown")
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(.secondary)
        }
    }
    
    private var entriesList: some View {
        ForEach(entries ){ entry in
            MoodEntryRow(entry : entry , onDelete: {onDelete(entry)})
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
    let previewEntries = [
          MoodModel(mood: "😊", note: "Had a great day!"),
          MoodModel(mood: "😴", note: "Very tired today"),
          MoodModel(mood: "🥰", note: "Feeling loved")
      ]
      
      return RecentMoodEntriesView(entries: previewEntries, onDelete: { _ in })
          .padding()
}
