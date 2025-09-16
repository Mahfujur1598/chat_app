# Chat App with Firebase

A real-time chat application built using Flutter and Firebase. This app allows users to sign in using Firebase Authentication, chat in real-time using Firestore.

### Key Features:
- User Authentication: Email/Password.
- Real-Time Messaging: Messages stored in Firestore and updated in real-time.

### Technologies Used:
- Flutter: For building the cross-platform mobile app.
- Firebase: Firebase Authentication, Firestore.
- MVVM Architecture: For better code maintainability and testability.

### Firebase Setup:

#### Firebase Console Setup:
1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Create a new project (or use an existing one).
3. Enable Firebase Authentication:
    - Go to Authentication > Sign-in method > Enable Email/Password.
4. Set up Firestore:
    - Go to Firestore Database > Create database and select Start in test mode (Remember to update security rules later).

#### Firebase Configuration:

1. Download the google-services.json (for Android).
2. Place google-services.json into `android/app` directory for Android.


#### Firebase Rules:
For testing purposes, you can use the following permissive Firestore rules:

```plaintext
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /rooms/{roomId}/messages/{messageId} {
      allow read, write: if true;
    }
  }
}
After testing, update the rules to allow access only to authenticated users:

plaintext
Copy code
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /rooms/{roomId}/messages/{messageId} {
      allow read, write: if request.auth != null;
    }
  }
}
