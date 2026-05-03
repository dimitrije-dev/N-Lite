//
//  HomeViewModel.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import Foundation



@Observable class HomeViewModel {
    
    var greeting : String = ""
    var subGreeting: String = ""
    var dateLabel: String = ""
    var motivationalQuote: String = ""
    
    private var quotes = [
        "Every day is a fresh start.",
        "Your feelings are valid.",
        "Small steps lead to big changes.",
        "Be kind to yourself today.",
        "Progress, not perfection.",
        "You're doing better than you think.",
        "Today is full of possibilities.",
        "Your mental health matters."
    ]
    init(){
        updateGreeting()
        updateDateLabel()
        updateQuote()
        
        
    }
    
    
    func updateGreeting(){
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour{
        case 4..<12:
            greeting = "Good morning"
            subGreeting = "A calm start builds momentum for the whole day."
        case 12..<17:
            greeting = "Good afternoon"
            subGreeting = "A short check-in can reset your focus."
        case 17..<22:
            greeting = "Good evening"
            subGreeting = "Reflect on today and close the day with clarity."
        default:
            greeting = "Good night"
            subGreeting = "Capture your mood before you rest."
            
        }
    }
    
    func updateDateLabel() {
        dateLabel = Date().formatted(.dateTime.weekday(.wide).day().month(.wide))
    }
    
    func updateQuote(){
        motivationalQuote = quotes.randomElement() ?? quotes[0]
    }
}
