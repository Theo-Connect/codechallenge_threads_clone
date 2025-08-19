# Threads Clone

A Flutter implementation of the Threads app with the following features:

## Features

1. **Home Screen**: Scrollable list of posts
2. **Post Component**: 
   - Text-only posts
   - Image posts with swipe functionality
   - User avatars and interaction buttons
3. **Navigation**: 5-tab bottom navigation (Home, Search, Write Thread, Notifications, Profile)

## Getting Started

1. Make sure you have Flutter installed
2. Navigate to the project directory:
   ```bash
   cd threads_clone
   ```
3. Get dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── constants/
│   ├── gaps.dart
│   └── sizes.dart
├── features/
│   ├── home/
│   │   └── home_screen.dart
│   └── navigation/
│       └── main_navigation.dart
├── models/
│   └── post.dart
├── widgets/
│   └── post_widget.dart
└── main.dart
```

## Design Features

- Clean, minimal UI matching Threads design
- Image carousel with page indicators
- Thread-like post layout with user avatars
- Responsive bottom navigation
- Smooth animations and transitions