# Realtime Quizzes

Challenge other players in realtime quizzes! This Flutter application allows users to compete in online games against other players and offline games, manage friends, and track their progress.

## App Preview

|   |   |   |
|---|---|---|
| <img src="app_preview/Screenshot_2025-11-22-18-35-25-317_com.example.realtime_quizzes.jpg" width="200" /> | <img src="app_preview/Screenshot_2025-11-22-21-28-33-109_com.example.realtime_quizzes.jpg" width="200" /> | <img src="app_preview/Screenshot_2025-11-22-21-45-38-403_com.example.realtime_quizzes.jpg" width="200" /> |
| <img src="app_preview/Screenshot_2025-11-22-22-06-05-486_com.example.realtime_quizzes.jpg" width="200" /> | <img src="app_preview/Screenshot_2025-11-22-22-08-11-253_com.example.realtime_quizzes.jpg" width="200" /> | <img src="app_preview/Screenshot_2025-11-22-22-08-39-389_com.example.realtime_quizzes.jpg" width="200" /> |
| <img src="app_preview/Screenshot_2025-11-22-22-08-46-866_com.example.realtime_quizzes.jpg" width="200" /> | <img src="app_preview/Screenshot_2025-11-22-22-10-05-027_com.example.realtime_quizzes.jpg" width="200" /> | |

## Features

- **Authentication**: Secure Login, Registration, and Password Reset functionality.
- **Realtime Multiplayer**: Create games and challenge friends or other users in real-time.
- **Single Player Mode**: Practice and test your knowledge with single-player quizzes.
- **Friends System**: Search for users, send friend requests, and manage your friends list.
- **Profile Management**: View and update your profile.
- **Leaderboards & Results**: Track your scores and compare with others.

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [GetX](https://pub.dev/packages/get)
- **Backend**: Firebase (Auth, Firestore, Storage)
- **Networking**: Dio
- **UI Components**: 
  - Syncfusion Flutter Sliders
  - Shimmer
  - Flutter SVG
  - Badges

## Getting Started

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/yourusername/realtime_quizzes.git
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Environment Configuration:**
    - Create a `.env` file in the root directory with your API keys:
      ```
      TRIVIA_API_KEY=your_api_key_here
      ```

4.  **Firebase Setup:**
    - Ensure you have a `google-services.json` file in `android/app/` for Android.
    - Ensure you have a `GoogleService-Info.plist` in `ios/Runner/` for iOS.

5.  **Run the app:**
    ```bash
    flutter run
    ```
