//
//  MoodLoggerView.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import SwiftUI

struct MoodLoggerView: View {
    @State private var moodViewModel: MoodViewModel = MoodViewModel()
    @State private var showingSaveAlert  = false
    @State private var animateMoods = false
    @State private var animateForm = false
    
    @FocusState private var isNoteFocused: Bool
    
    var body: some View {
        
        ZStack{
            Color.backgroundColorCustom.ignoresSafeArea()
            
            ScrollView{
                VStack(spacing:24){
                    
                }
            }
        }
       

    }
}

#Preview {
    MoodLoggerView()
}
