//
//  NoteInputVIew.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 5. 11. 2025..
//

import SwiftUI

struct NoteInputView: View {
    @Binding var moodNote: String
    @FocusState.Binding var isNoteFocused: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 12, ) {
            Text("Add a Note (Optional)")
                .font(.system(size:20 ,weight: .semibold , design: .rounded))
                .foregroundStyle(.primary)
            
            Text("What' on your mind? ")
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundStyle(.secondary)
            
            ZStack(alignment: .topLeading){
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.primaryColorCustom.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(isNoteFocused ? Color.primaryColorCustom : Color.clear, lineWidth: 2)
                    )
                
                if moodNote.isEmpty {
                    Text("Describe your feelings, thoughts, or what happened today...")
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .foregroundStyle(.tertiary)
                        .padding(12)
                }
                
                TextEditor(text: $moodNote)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .scrollContentBackground(.hidden)
                    .padding(8)
                    .frame(minHeight: 100)
                    .focused($isNoteFocused)
            }
            .frame(minHeight: 100)
            
            
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 4)
        )
    }
}

#Preview {
    @Previewable @State var note = ""
    @Previewable @FocusState var isFocused: Bool
    
    NoteInputView(moodNote: $note, isNoteFocused: $isFocused)
        .padding()
}
