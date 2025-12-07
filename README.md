# Mus3if - First Aid Mobile Application 🚑

<div align="center">
  <img src="assets/icons/Mus3if_app_icon.png" alt="Mus3if Logo" width="200"/>
  
  **Your Guide to Emergency Care**
  
</div>

---

## 📖 Table of Contents
- [Overview](#overview)
- [Features](#features)
- [User Management](#user-management)
- [Tech Stack](#tech-stack)
- [Installation](#installation)
- [Configuration](#configuration)
- [Project Structure](#project-structure)
- [Usage Guide](#usage-guide)
- [Contributing](#contributing)
- [Team](#team)


---

## 🎯 Overview

**Mus3if** is a comprehensive first aid mobile application built with Flutter that provides users with critical emergency information, step-by-step first aid guides, hospital locations, and an AI-powered medical assistant. The app is designed to help users respond effectively in emergency situations.

### Key Objectives
- Provide quick access to first aid instructions
- Enable fast emergency contact calling
- Locate nearby hospitals with navigation
- Offer AI-powered medical guidance
- Manage personal emergency contacts

---

## ✨ Features

### 🏥 Core Features
- **Interactive First Aid Guides**: Step-by-step instructions for:
  - CPR (Cardiopulmonary Resuscitation)
  - Burns Treatment
  - Fracture Management
  - Bleeding Control
  - Choking Response

- **Hospital Locator**: 
  - Real-time GPS location tracking
  - Distance calculation to nearby hospitals
  - Direct navigation via Google Maps
  - One-tap emergency calling

- **Emergency Contacts Management**:
  - Personal contacts
  - Doctor contacts with specialties
  - Hospital contacts
  - Quick call functionality

- **AI Medical Assistant** 🤖:
  - Powered by Google Gemini AI
  - Real-time medical guidance
  - Multi-language support (English/Arabic)
  - Strict safety protocols (no diagnosis/prescription)

- **First Aid Kit Reference**:
  - Medical supplies catalog
  - Usage instructions
  - Safety notes and warnings

### 🔐 User Management
- **Firebase Authentication**:
  - Email/Password registration
  - Google Sign-In integration
  - Email verification
  - Password reset functionality

- **User Profile**:
  - Personal information management
  - Blood type recording
  - Profile photo upload
  - Medical information storage

### 📺 Educational Content
- Curated YouTube video tutorials
- Visual first aid demonstrations
- Expert medical guidance

---

## 🛠️ Tech Stack

### Frontend
- **Flutter** 3.8.1 - Cross-platform mobile framework
- **Dart** - Programming language

### Backend & Services
- **Firebase Suite**:
  - Firebase Authentication
  - Firebase Firestore (Database)
  
### AI & APIs
- **Google Gemini AI** - Medical chatbot
- **Google Maps API** - Location services
- **Geolocator** - GPS positioning

### Key Packages
```yaml
dependencies:
  firebase_core: ^4.2.0
  firebase_auth: ^6.1.2
  cloud_firestore: ^6.1.0
  google_sign_in: ^5.4.4
  flutter_gemini: ^3.0.0
  geolocator: ^13.0.2
  url_launcher: ^6.3.2
  image_picker: ^1.2.1
  cached_network_image: ^3.3.1
  shared_preferences: ^2.2.2
  lottie: ^3.3.1
```

---

## 🚀 Installation

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Android Studio / Xcode
- Firebase account
- Google Gemini API key

### Steps

1. **Clone the repository**
```bash
git clone https://github.com/YomnaIbrahim4/Mus3if.git
cd Mus3if
```

2. **Install dependencies**
```bash
flutter pub get
flutter doctor
```

3. **Configure Firebase**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Add Android/iOS apps to your Firebase project
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in the appropriate directories

4. **Set up API keys**
   - Create `lib/config/keys.dart` from the example:
   ```dart
   const String GEMINI_API_KEY = "YOUR_GEMINI_API_KEY_HERE";
   ```

5. **Run the app**
```bash
flutter run
```

---

## ⚙️ Configuration

### Firebase Setup

1. **Authentication**
   - Enable Email/Password authentication
   - Enable Google Sign-In provider
   - Configure OAuth consent screen

2. **Firestore Database**
   - Create a `users` collection
   - Set up security rules:
   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /users/{userId} {
         allow read, write: if request.auth != null && request.auth.uid == userId;
       }
     }
   }
   ```

### Google Gemini API

1. Get your API key from [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Add it to `lib/config/keys.dart`

### Location Services

**Android** (`android/app/src/main/AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

**iOS** (`ios/Runner/Info.plist`):
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to find nearby hospitals</string>
```

---

## 📁 Project Structure

```
mus3if/
├── lib/
│   ├── config/              # API keys and configuration
│   ├── data/                # Data models and dummy data
│   │   ├── firebaseFanction/  # Firebase authentication logic
│   │   └── validation/        # Form validation
│   ├── local_storage/       # SharedPreferences logic
│   ├── models/              # Data models
│   ├── screens/             # UI screens
│   ├── services/            # Business logic services
│   ├── tabs/                # Bottom navigation tabs
│   ├── widgets/             # Reusable UI components
│   └── main.dart            # App entry point
├── assets/
│   ├── images/              # App images
│   ├── guides/              # JSON first aid guides
│   ├── animation/           # Lottie animations
│   └── icons/               # App icons
├── android/                 # Android native code
├── ios/                     # iOS native code
└── pubspec.yaml             # Dependencies
```

---

## 📚 Usage Guide

### For Users

1. **Registration**
   - Sign up with email/password or Google
   - Verify your email
   - Complete your profile (name, blood type)

2. **Accessing First Aid Guides**
   - Navigate to Home tab
   - Select a guide category
   - Follow step-by-step instructions

3. **Finding Hospitals**
   - Go to Hospitals tab
   - Allow location permissions
   - View nearby hospitals sorted by distance
   - Get directions or call directly

4. **Using AI Assistant**
   - Tap the floating AI button
   - Ask first aid related questions
   - Receive instant guidance

5. **Managing Contacts**
   - Go to Profile > Emergency Contacts
   - Add personal, doctor, or hospital contacts
   - Quick call with one tap

### For Developers

#### Adding New First Aid Guides

1. Create a JSON file in `assets/guides/`:
```json
{
  "title": "New Guide",
  "steps": [
    {
      "title": "Step 1",
      "description": "Detailed instructions..."
    }
  ]
}
```

2. Add to `lib/data/categories_list.dart`:
```dart
CategoryModel(
  imagePath: 'assets/images/new_guide.jpg',
  categoryTitle: 'New Guide',
  categorySubTitle: 'Description',
  jsonPath: 'assets/guides/new_guide.json',
)
```

#### Customizing AI Responses

Edit the system prompt in `lib/screens/medical_chat_screen.dart`:
```dart
const systemPrompt = '''
Your custom instructions here...
''';
```

---

## 🤝 Contributing

We welcome contributions! Here's how:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Coding Standards
- Follow Flutter/Dart style guide
- Write meaningful commit messages
- Add comments for complex logic
- Test thoroughly before submitting

---

## 👥 Team

- *Yomna Ibrahim*
- *Doaa Magdy*
- *Rawan Gamal*
- *Faten Hisham*

---

<div align="center">
  <p>Made with ❤️ for saving lives</p>
  <p>⭐ Star this repo if you find it useful!</p>
</div>
