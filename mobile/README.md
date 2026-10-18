# Campus AR Mobile App

This is the starter Flutter app for the Campus AR Navigation & Accessibility Assistant.

Requirements
- Flutter SDK installed
- Android Studio or Xcode for device running
- Real device recommended for BLE and AR testing

Setup

1. Open repo in VS Code
2. Go to mobile folder
3. Run:
   flutter pub get
   flutter run

Notes
- The backend should be running at http://10.0.2.2:3000 for Android emulator
- For real device, update the API base URL in `mobile/lib/services/api_client.dart`
- AR and BLE features are scaffolded, but require final device-specific wiring

