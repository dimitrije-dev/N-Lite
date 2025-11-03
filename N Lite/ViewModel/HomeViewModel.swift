//
//  HomeViewModel.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import Foundation



@Observable class HomeViewModel {
    
    var greeting : String = ""
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
        updateQuote()
        
        
    }
    
    
    func updateGreeting(){
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour{
        case 0..<12:
            greeting = "Good Morning 🌅"
        case 12..<17:
            greeting = "Good Afternoon ☀️"
        case 17..<21:
            greeting = "Good Evening 🌆 "
        default:
            greeting = "Good Night 🌙"
            
        }
    }
    func updateQuote(){
        motivationalQuote = quotes.randomElement() ?? quotes[0]
    }
}
