//
//  SettingsViewModel.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 7. 11. 2025..
//

import Foundation
import SwiftUI

@Observable class SettingsViewModel {
    // App Settings
    var notificationsEnabled: Bool {
        didSet {
            UserDefaults.standard.set(notificationsEnabled, forKey: "notificationsEnabled")
        }
    }
    
    var notificationTime: Date {
        didSet {
            UserDefaults.standard.set(notificationTime, forKey: "notificationTime")
        }
    }
    
    var showStreakReminders: Bool {
        didSet {
            UserDefaults.standard.set(showStreakReminders, forKey: "showStreakReminders")
        }
    }
    
    // App Info
    let appVersion: String
    let buildNumber: String
    
    init() {
        // Load settings from UserDefaults
        self.notificationsEnabled = UserDefaults.standard.bool(forKey: "notificationsEnabled")
        
        if let savedTime = UserDefaults.standard.object(forKey: "notificationTime") as? Date {
            self.notificationTime = savedTime
        } else {
            // Default to 8:00 PM
            let calendar = Calendar.current
            var components = calendar.dateComponents([.year, .month, .day], from: Date())
            components.hour = 20
            components.minute = 0
            self.notificationTime = calendar.date(from: components) ?? Date()
        }
        
        self.showStreakReminders = UserDefaults.standard.bool(forKey: "showStreakReminders")
        
        // Get app version info
        self.appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        self.buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }
    
    func resetSettings() {
        notificationsEnabled = false
        showStreakReminders = false
        
        // Reset notification time to default (8:00 PM)
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        components.hour = 20
        components.minute = 0
        notificationTime = calendar.date(from: components) ?? Date()
    }
}
