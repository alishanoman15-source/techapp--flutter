# TechApp - Flutter Authentication App

## 📱 Description
A complete Flutter application with user authentication, profile management, and local data storage.

## ✨ Features
- Splash Screen with smooth animations
- User Registration (Signup) with validation
- Secure User Login
- View User Profile with API data
- Edit Profile functionality
- Logout with data clearing
- Local Storage using Hive database
- Beautiful Material Design 3 UI
- Error handling and loading states

## 🛠️ Technologies Used
- Flutter (UI Framework)
- Dart (Programming Language)
- Hive (Local Database)
- HTTP (API Calls)
- Material Design 3 (UI Design)

## 📋 Project Structuretechapp/
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── splash_screen.dart
│   │   ├── login_screen.dart
│   │   ├── signup_screen.dart
│   │   ├── profile_screen.dart
│   │   └── edit_profile_screen.dart
│   ├── services/
│   │   ├── api_service.dart
│   │   └── storage_service.dart
│   ├── constants/
│   │   ├── app_colors.dart
│   │   └── app_strings.dart
│   └── models/
│       └── user_model.dart
├── pubspec.yaml
└── README.md

## 🚀 How to Run

1. Make sure you have Flutter installed
2. Clone or extract the project
3. Open terminal in project folder
4. Run: `flutter pub get`
5. Run: `flutter run`

## 📖 API Used
- **Base URL:** https://api.genzpro.pk
- **Endpoints:**
  - `/signup.php` - User registration
  - `/login.php` - User login
  - `/get_profile.php` - Get user profile
  - `/update_profile.php` - Update user profile

## 🎯 App Flow
1. App opens → Splash screen (3 seconds)
2. User sees Login screen
3. Can click "Sign Up" to create account
4. After signup/login → Profile screen
5. Can edit profile
6. Can logout

## ✅ Testing
All screens have been tested and working:
- ✅ Splash with animations
- ✅ Login with validation
- ✅ Signup with all fields
- ✅ Profile view
- ✅ Profile edit
- ✅ Logout functionality

## 📸 Screenshots
See `screenshots/` folder for app screenshots

## 👨‍💻 Author
Alisha - BSIT Student

## 📅 Date
May 2026

## 📝 Notes
This project was built as a learning exercise to understand:
- Flutter app development
- API integration
- Form validation
- State management
- Local data storage
- Professional UI design