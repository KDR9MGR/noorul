# Noor ul Mustakeem - Islamic App

A comprehensive Islamic app built with Flutter that provides essential features for Muslims.

## Features

- 🕌 Prayer Times
  - Accurate prayer time calculations based on location
  - Multiple calculation methods support
  - Prayer time notifications

- 🧭 Qibla Direction
  - Accurate Qibla direction using device sensors
  - Compass functionality

- 📍 Nearby Mosques
  - Find nearby mosques on the map
  - Get directions to mosques

- 📖 Daily Duas
  - Collection of essential daily duas
  - Easy to access and read

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/noorulmustakeem.git
```

2. Navigate to the project directory:
```bash
cd noorulmustakeem
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

### Configuration

The app uses several APIs and services that require configuration:

1. Google Maps API
   - Get an API key from Google Cloud Console
   - Add it to your `android/app/src/main/AndroidManifest.xml` and `ios/Runner/AppDelegate.swift`

2. Location Services
   - The app requires location permissions for accurate prayer times and qibla direction
   - Configure permissions in `android/app/src/main/AndroidManifest.xml` and `ios/Runner/Info.plist`

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
