<div align="center">

# 🌙 N Lite

### *Your Personal Mental Wellness Companion*

![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-blue.svg)
![iOS](https://img.shields.io/badge/iOS-26.0+-green.svg)
![Status](https://img.shields.io/badge/Status-In%20Development-yellow.svg)
![License](https://img.shields.io/badge/License-MIT-purple.svg)

*Track your moods, visualize your progress, and nurture your mental wellness journey* ✨

[Features](#-features) • [Screenshots](#-screenshots) • [Architecture](#-architecture) • [Installation](#-installation) • [Roadmap](#-roadmap)

---

</div>

## 🌟 Overview

**N Lite** is a beautifully crafted iOS application designed to help users track their daily moods and mental wellness journey. Built with SwiftUI and following modern iOS development practices, N Lite provides an intuitive and visually appealing interface for logging emotions, viewing progress, and maintaining mindfulness.

### ✨ Why N Lite?

- 🎨 **Beautiful Design**: Glassmorphic UI with smooth animations
- 🌈 **Mood Tracking**: Easy-to-use emoji-based mood logging
- 📊 **Progress Visualization**: Track your emotional patterns over time
- 🌙 **Smart Greetings**: Time-aware welcome messages
- 💭 **Daily Inspiration**: Motivational quotes to brighten your day
- 🎯 **Quick Actions**: One-tap access to core features

---

## 🚀 Features

### Currently Implemented

#### 🏠 Home Screen
- **Dynamic Greetings**: Context-aware messages based on time of day
  - 🌅 Morning (0:00 - 12:00)
  - ☀️ Afternoon (12:00 - 17:00)
  - 🌆 Evening (17:00 - 21:00)
  - 🌙 Night (21:00 - 0:00)
- **Inspirational Quotes**: Rotating collection of motivational messages
- **Quick Action Cards**: Beautiful glassmorphic cards with smooth interactions

#### 🎨 UI Components
- **CardComponent**: Reusable glassmorphic card with gradient accents
- **InteractiveCard**: Animated cards with press feedback
- **MoodButton**: Emoji-based mood selection with scale animations
- **MoodCard**: Display cards for mood entries with gradients

#### 🎨 Design System
- **Custom Color Palette**:
  - Primary: Vibrant teal-green gradient
  - Secondary: Fresh mint-green tones
  - Background: Adaptive light/dark themes
  - Text: High contrast for readability
- **Glassmorphism Effects**: Modern frosted glass UI elements
- **Smooth Animations**: Spring-based animations throughout

### 🔨 In Development

- 📝 **Mood Logger**: Complete mood entry system
- 📈 **Progress Dashboard**: Visual analytics and insights
- ⚙️ **Settings Panel**: Customization options
- 💾 **Data Persistence**: Local storage with UserDefaults/CoreData
- 📱 **Notifications**: Daily mood check-in reminders

---

## 📱 Screenshots

<div align="center">

### Home Screen
*Beautiful gradient header with time-aware greetings and quick actions*

<img width="379" height="712" alt="Screenshot 2025-11-04 at 00 42 01" src="https://github.com/user-attachments/assets/c2620e25-85e3-47dd-9192-e513d00f7b90" />


*Clean, modern interface with glassmorphic design elements*

</div>

---

## 🏗 Architecture

### Project Structure

```
N Lite/
├── Model/
│   └── MoodModel.swift           # Data model for mood entries
├── View/
│   ├── ContentView.swift          # Main tab view container
│   ├── HomeView.swift             # Home screen with greetings
│   ├── MoodLoggerView.swift       # Mood entry interface
│   ├── ProgressView.swift         # Analytics dashboard
│   ├── SettingsView.swift         # App settings
│   └── Components/
│       ├── CardComponent.swift    # Reusable card UI
│       ├── InteractiveCard.swift  # Animated card wrapper
│       ├── MoodButton.swift       # Mood selection button
│       ├── MoodCard.swift         # Mood display card
│       └── VerticalListView.swift # Quick actions list
├── ViewModel/
│   ├── HomeViewModel.swift        # Home screen logic
│   └── MoodViewModel.swift        # Mood management (WIP)
└── Assets.xcassets/
    ├── AccentColor.colorset       # App accent colors
    ├── BackgroundColorCustom      # Adaptive backgrounds
    ├── PrimaryColorCustom         # Primary brand color
    ├── SecondaryColorCustom       # Secondary brand color
    └── TextColorCustom            # Adaptive text colors
```

### Design Patterns

- **MVVM Architecture**: Clean separation of concerns
- **Observable Pattern**: SwiftUI's `@Observable` for reactive updates
- **Component-Based Design**: Reusable, composable UI elements
- **Adaptive Design**: Full light/dark mode support

### Technologies

- **SwiftUI**: Modern declarative UI framework
- **Observation Framework**: State management
- **Codable**: Data serialization
- **TabView**: Native iOS navigation
- **Custom Color Assets**: Adaptive theming system

---

## 💻 Installation

### Prerequisites

- **Xcode 26.0+** (Beta)
- **iOS 26.0+** SDK
- **macOS Sequoia** or later
- **Swift 5.0+**

---

## 🎨 Customization

### Color Scheme

The app uses a custom color system defined in Asset Catalogs:

- **Primary Color**: `#9BCF3A` (Light) / `#91C530` (Dark)
- **Secondary Color**: `#88E2A5` (Light) / `#1D773A` (Dark)
- **Background**: `#F9FDF3` (Light) / `#090C03` (Dark)
- **Accent**: `#63D9AE` (Light) / `#269C71` (Dark)

### Motivational Quotes

Customize quotes in `HomeViewModel.swift`:

```swift
private var quotes = [
    "Every day is a fresh start.",
    "Your feelings are valid.",
    // Add your custom quotes here
]
```

---

## 🗺 Roadmap

### Phase 1: Core Features ✅
- [x] Project setup and architecture
- [x] Custom color system
- [x] Reusable UI components
- [x] Home screen with greetings
- [x] Navigation structure

### Phase 2: Mood Tracking 🚧
- [ ] Complete mood logger interface
- [ ] Emoji selection grid
- [ ] Note-taking functionality
- [ ] Data persistence layer
- [ ] Entry validation

### Phase 3: Analytics 📊
- [ ] Progress dashboard
- [ ] Mood frequency charts
- [ ] Weekly/monthly summaries
- [ ] Trend analysis
- [ ] Export functionality

### Phase 4: Polish & Features ✨
- [ ] Settings and preferences
- [ ] Dark mode refinements
- [ ] Haptic feedback
- [ ] App icons and launch screen
- [ ] Onboarding flow
- [ ] Push notifications
- [ ] Widget support

### Phase 5: Advanced Features 🚀
- [ ] iCloud sync
- [ ] Journal entries
- [ ] Mood patterns AI insights
- [ ] Health app integration
- [ ] Shortcuts support
- [ ] iPad optimization

---


## 👨‍💻 Author

**Dimitrije Milenkovic**

---


<div align="center">

### Made with 💚 and SwiftUI

**N Lite** - *Every day is a fresh start* 🌅


</div>
