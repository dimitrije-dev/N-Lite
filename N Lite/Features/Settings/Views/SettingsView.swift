//
//  SettingsView.swift
//  N Lite
//
//  Created by Dimitrije Milenkovic on 3. 11. 2025..
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var moodEntries: [MoodModel]
    
    @State private var viewModel = SettingsViewModel()
    @State private var showingDeleteAlert = false
    @State private var showingResetAlert = false
    @State private var showingExportSuccess = false
    
    var body: some View {
        ZStack {
            Color.backgroundColorCustom.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    headerSection
                        .padding(.top, 20)
                    
                    // Notifications Section
                    notificationsSection
                    
                    // Data Management Section
                    dataSection
                    
                    // About Section
                    aboutSection
                    
                    // Danger Zone
                    dangerZone
                }
                .padding(.horizontal)
                .padding(.bottom, 100)
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete All Data", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                deleteAllData()
            }
        } message: {
            Text("Are you sure you want to delete all mood entries? This action cannot be undone.")
        }
        .alert("Reset Settings", isPresented: $showingResetAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Reset", role: .destructive) {
                viewModel.resetSettings()
            }
        } message: {
            Text("This will reset all settings to their default values.")
        }
        .alert("Export Successful", isPresented: $showingExportSuccess) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Your mood data has been exported successfully!")
        }
    }
    
    // MARK: - Header Section
    
    private var headerSection: some View {
        VStack(spacing: 8) {
            Image(systemName: "gearshape.fill")
                .font(.system(size: 50))
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.primaryColorCustom, Color.secondaryColorCustom],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            Text("Settings")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)
            
            Text("Customize your experience")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(.secondary)
        }
        .padding(.bottom, 8)
    }
    
    // MARK: - Notifications Section
    
    private var notificationsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SettingsSectionHeader(title: "Notifications")
            
            VStack(spacing: 8) {
                SettingsToggleRow(
                    icon: "bell.fill",
                    iconColor: .blue,
                    title: "Daily Reminders",
                    subtitle: "Get reminded to log your mood",
                    isOn: $viewModel.notificationsEnabled
                )
                
                if viewModel.notificationsEnabled {
                    timePickerRow
                    
                    SettingsToggleRow(
                        icon: "flame.fill",
                        iconColor: .orange,
                        title: "Streak Reminders",
                        subtitle: "Don't break your streak!",
                        isOn: $viewModel.showStreakReminders
                    )
                }
            }
        }
    }
    
    private var timePickerRow: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.purple.opacity(0.15))
                    .frame(width: 36, height: 36)
                
                Image(systemName: "clock.fill")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.purple)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Reminder Time")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundStyle(.primary)
                
                Text("Choose when to be reminded")
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            DatePicker("", selection: $viewModel.notificationTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.primaryColorCustom.opacity(0.05))
        )
    }
    
    // MARK: - Data Section
    
    private var dataSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SettingsSectionHeader(title: "Data Management")
            
            VStack(spacing: 8) {
                dataStatRow(
                    icon: "chart.bar.fill",
                    title: "Total Entries",
                    value: "\(moodEntries.count)",
                    color: .primaryColorCustom
                )
                
                SettingsRow(
                    icon: "square.and.arrow.up.fill",
                    iconColor: .green,
                    title: "Export Data",
                    subtitle: "Save your mood history",
                    action: exportData
                )
                
                SettingsRow(
                    icon: "arrow.clockwise",
                    iconColor: .orange,
                    title: "Reset Settings",
                    subtitle: "Restore default preferences",
                    action: { showingResetAlert = true }
                )
            }
        }
    }
    
    private func dataStatRow(icon: String, title: String, value: String, color: Color) -> some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color.opacity(0.15))
                    .frame(width: 36, height: 36)
                
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(color)
            }
            
            Text(title)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(.primary)
            
            Spacer()
            
            Text(value)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(color)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.primaryColorCustom.opacity(0.05))
        )
    }
    
    // MARK: - About Section
    
    private var aboutSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SettingsSectionHeader(title: "About")
            
            VStack(spacing: 8) {
                aboutRow(
                    icon: "info.circle.fill",
                    title: "Version",
                    value: viewModel.appVersion,
                    color: .blue
                )
                
                aboutRow(
                    icon: "hammer.fill",
                    title: "Build",
                    value: viewModel.buildNumber,
                    color: .purple
                )
                
                SettingsRow(
                    icon: "heart.fill",
                    iconColor: .pink,
                    title: "Rate N Lite",
                    subtitle: "Share your feedback",
                    action: {}
                )
                
                SettingsRow(
                    icon: "envelope.fill",
                    iconColor: .cyan,
                    title: "Contact Support",
                    subtitle: "Get help and support",
                    action: {}
                )
            }
        }
    }
    
    private func aboutRow(icon: String, title: String, value: String, color: Color) -> some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color.opacity(0.15))
                    .frame(width: 36, height: 36)
                
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(color)
            }
            
            Text(title)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(.primary)
            
            Spacer()
            
            Text(value)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.primaryColorCustom.opacity(0.05))
        )
    }
    
    // MARK: - Danger Zone
    
    private var dangerZone: some View {
        VStack(alignment: .leading, spacing: 12) {
            SettingsSectionHeader(title: "Danger Zone")
            
            SettingsRow(
                icon: "trash.fill",
                iconColor: .red,
                title: "Delete All Data",
                subtitle: "Permanently remove all mood entries",
                action: { showingDeleteAlert = true }
            )
        }
    }
    
    // MARK: - Actions
    
    private func deleteAllData() {
        for entry in moodEntries {
            modelContext.delete(entry)
        }
        try? modelContext.save()
    }
    
    private func exportData() {
        // This is a placeholder - in a real app, you'd implement actual export functionality
        showingExportSuccess = true
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .modelContainer(for: MoodModel.self, inMemory: true)
    }
}
