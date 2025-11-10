<div align="center">

# 🌙 N Lite

### *Your Personal Mental Wellness Companion*

![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-blue.svg)
![iOS](https://img.shields.io/badge/iOS-26.0+-green.svg)
![SwiftData](https://img.shields.io/badge/SwiftData-Enabled-orange.svg)
![Status](https://img.shields.io/badge/Status-Beta-brightgreen.svg)

*Track your moods, visualize your progress, and nurture your mental wellness journey* ✨

[Features](#-features) • [Screenshots](#-screenshots) • [Architecture](#-architecture) • [Installation](#-installation) • [Future Plans](#-future-plans)

---

</div>

##  Overview

**N Lite** is a beautifully crafted iOS application designed to help users track their daily moods and mental wellness journey. Built with SwiftUI, SwiftData, and following modern iOS development practices, N Lite provides an intuitive and visually appealing interface for logging emotions, viewing progress analytics, and maintaining mindfulness.


## Features

### 🏠 Home Screen
- **Dynamic Time-Aware Greetings**: Contextual messages based on time of day
  - 🌅 Good Morning (4:00 - 12:00)
  - ☀️ Good Afternoon (12:00 - 17:00)
  - 🌆 Good Evening (17:00 - 22:00)
  - 🌙 Good Night (22:00 - 4:00)
- **Inspirational Quote Card**: Rotating motivational messages with refresh button
- **Quick Action Cards**: Animated glassmorphic cards for instant navigation
- **Smooth Animations**: Staggered entrance animations for visual polish

### 📝 Mood Logger
- **8 Mood Options**: Comprehensive emoji-based mood selection
  - 😊 Happy
  - 😔 Sad
  - 😴 Tired
  - 😰 Anxious
  - 😡 Angry
  - 🥰 Loved
  - 😎 Confident
  - 🤔 Thoughtful
- **Optional Notes**: Add context to your mood entries with a text editor
- **Today's Status**: Visual indicator when mood is already logged
- **Recent Entries View**: Quick access to your last 5 mood logs
- **Keyboard Management**: Smart scrolling and dismiss functionality
- **Save Confirmation**: Alert feedback when mood is successfully saved
- **SwiftData Persistence**: Reliable local storage of all entries

### 📊 Progress Dashboard
- **Key Statistics**:
  -  Current Streak (consecutive daily logs)
  -  Longest Streak achieved
  -  Total Entries count
  -  Average Entries per Week
- **Weekly Overview Chart**: Visual bar chart showing mood frequency per day
- **Mood Distribution Analysis**:
  - Percentage breakdown of each mood
  - Count-based ranking
  - Visual progress bars with gradients
- **Insights Section**:
  - Most Common Mood identification
  - Tracking time range display
- **Empty State**: Encouraging message for new users
- **Smooth Animations**: Staggered loading for enhanced UX

### ⚙️ Settings
- **Notifications Management**:
  - Daily reminder toggle
  - Custom reminder time picker
  - Streak reminder notifications
- **Data Management**:
  - Total entries display
  - Export data functionality (placeholder)
  - Reset settings to defaults
  - Delete all data with confirmation
- **App Information**:
  - Version number display
  - Build number display
  - Rate app (placeholder)
  - Contact support (placeholder)
- **User-Friendly Layout**: Organized sections with clear headers

## Screenshots

<div align="center">

### Home Screen
*Beautiful gradient header with time-aware greetings and quick actions*

<img width="373" height="777" alt="Home" src="https://github.com/user-attachments/assets/8de02233-57ff-4b38-a9e9-fa30f1991ac4" />


### Mood Logger
*Intuitive emoji-based mood selection with optional notes*

<img width="381" height="772" alt="Log" src="https://github.com/user-attachments/assets/ef500814-3454-47b3-a38a-accbbc65b668" />



### Progress Dashboard
*Comprehensive analytics and visualizations of your mood journey*

<img width="371" height="753" alt="Progress 2" src="https://github.com/user-attachments/assets/50a969a6-4514-45c1-b4e0-3bc6de4823ea" />
<img width="367" height="755" alt="Progress" src="https://github.com/user-attachments/assets/a94e1829-cc6b-45a3-9d3b-6b1d3f1b8914" />



### Settings
*Customization and data management options*

<img width="375" height="761" alt="Settings" src="https://github.com/user-attachments/assets/6f9fc3af-d038-4102-8e8d-99b796e251ed" />


</div>

---

## 🏗 Architecture

### Project Structure

```
N Lite/
├── App/
│   ├── N_LiteApp.swift              # App entry point with SwiftData configuration
│   └── ContentView.swift             # Main TabView container
│
├── Features/
│   ├── Home/
│   │   ├── HomeView.swift            # Home screen view
│   │   ├── ViewModels/
│   │   │   └── HomeViewModel.swift   # Home logic and quotes
│   │   └── Views/Components/
│   │       ├── CardComponent.swift         # Reusable glassmorphic card
│   │       ├── InteractiveCard.swift       # Animated card wrapper
│   │       ├── HomeHeaderView.swift        # Gradient header component
│   │       ├── QuoteCardView.swift         # Quote display card
│   │       ├── SectionHeaderView.swift     # Section titles
│   │       └── VerticalListView.swift      # Quick actions list
│   │
│   ├── MoodLogger/
│   │   ├── MoodLoggerView.swift      # Main mood entry interface
│   │   ├── ViewModels/
│   │   │   └── MoodViewModel.swift   # Mood management and analytics
│   │   └── Views/Components/
│   │       ├── MoodButton.swift            # Mood selection button
│   │       ├── MoodCard.swift              # Mood display card
│   │       ├── MoodLoggerHeaderView.swift  # Logger header
│   │       ├── MoodSelectionView.swift     # Mood grid selector
│   │       ├── NoteInputView.swift         # Note text editor
│   │       ├── RecentMoodEntriesView.swift # Recent entries list
│   │       ├── SaveMoodButton.swift        # Animated save button
│   │       └── TodaysMoodCardView.swift    # Today's status card
│   │
│   ├── Progress/
│   │   ├── ProgressView.swift        # Analytics dashboard
│   │   ├── ViewModels/
│   │   │   └── ProgressViewModel.swift # Analytics calculations
│   │   └── Views/Components/
│   │       ├── MoodDistributionChart.swift # Distribution visualization
│   │       ├── StatCard.swift              # Statistic display card
│   │       └── WeeklyOverview.swift        # Weekly mood chart
│   │
│   └── Settings/
│       ├── SettingsView.swift        # Settings interface
│       ├── ViewModels/
│       │   └── SettingsViewModel.swift # Settings management
│       └── Views/Components/
│           ├── SettingsRow.swift           # Settings item row
│           └── SettingsSectionHeader.swift # Section headers
│
├── Models/
│   └── MoodModel.swift               # SwiftData mood entry model
│
└── Assets.xcassets/
    ├── AccentColor.colorset          # App accent colors
    ├── BackgroundColorCustom         # Adaptive backgrounds
    ├── PrimaryColorCustom            # Primary brand color
    ├── SecondaryColorCustom          # Secondary brand color
    └── TextColorCustom               # Adaptive text colors
```

### Design Patterns & Architecture

- **MVVM Architecture**: Clean separation of concerns with ViewModels
- **SwiftUI Observable Pattern**: Modern `@Observable` macro for reactive state
- **SwiftData**: Apple's latest persistence framework for local storage
- **Component-Based Design**: Highly reusable, composable UI components
- **Feature-Based Organization**: Modular structure by feature domain
- **Adaptive Design**: Full light/dark mode support throughout
- **Safe Area Management**: Proper handling of notch/Dynamic Island

### Key Technologies

- **SwiftUI**: Modern declarative UI framework
- **SwiftData**: Native persistence and data modeling
- **Observation Framework**: State management with `@Observable`
- **Combine**: For reactive data flow (implicit through SwiftUI)
- **SF Symbols**: Native iOS iconography
- **UserDefaults**: Settings persistence
- **@Environment & @Query**: SwiftData integration
- **@FocusState**: Keyboard management

### Data Flow

```
User Action → View → ViewModel → Model (SwiftData) → View Update
                ↑                                        ↓
                └────────── SwiftUI @Query ──────────────┘
```

---


### Prerequisites

- **Xcode 26.0+** (Beta)
- **iOS 26.0+** SDK
- **macOS Sequoia** or later
- **Swift 5.0+**


## 📊 Analytics Features

### Implemented Calculations

- **Current Streak**: Consecutive days with mood entries
- **Longest Streak**: All-time best streak
- **Average Entries per Week**: Historical average
- **Mood Distribution**: Percentage breakdown
- **Weekly Overview**: Last 7 days visualization
- **Most Common Mood**: Statistical mode
- **Time Range Tracking**: First to last entry dates

### Data Insights

- Real-time calculation of all metrics
- Persistent storage via SwiftData
- Efficient querying with `@Query` property wrapper
- Date-based filtering and sorting

---

## 🔧 Technical Highlights

### Performance Optimizations

- **LazyVGrid**: Efficient grid rendering for mood selection
- **SwiftData Queries**: Optimized database queries with sorting
- **Computed Properties**: Efficient data transformations
- **Animation Delays**: Staggered loading for smooth UX

### User Experience

- **Keyboard Dismissal**: Tap-to-dismiss and toolbar button
- **Smart Scrolling**: Auto-scroll to text input when focused
- **Haptic Feedback**: Spring animations for tactile feel
- **Error Prevention**: Save button disabled when no mood selected
- **Confirmation Dialogs**: Alerts for destructive actions

### Code Quality

- **MVVM Pattern**: Clear separation of business logic
- **Reusable Components**: DRY principle throughout
- **Type Safety**: Strong typing with Swift
- **SwiftUI Best Practices**: Modern declarative patterns
- **Comments**: Clear documentation where needed


---

## 📄 Requirements

- **iOS**: 26.0 or later
- **Xcode**: 26.0 or later (Beta)
- **Swift**: 5.0+
- **Minimum Storage**: ~10MB
- **Permissions**: Notifications (optional)

---


## 📝 Version History

### Beta (Current)
- ✅ Complete mood logging system
- ✅ Comprehensive analytics dashboard
- ✅ Settings and preferences
- ✅ SwiftData integration
- ✅ Full UI implementation

### Alpha (Previous)
- Basic UI framework
- Navigation structure
- Color system

---


*Track your emotions • Understand your patterns • Nurture your wellbeing*

⭐️ Star this repo if you find it helpful!

</div>
