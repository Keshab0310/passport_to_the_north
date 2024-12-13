# Passport to The North
![Logo](assets/logo.jpg)
A mobile application that blends exploration, gamification, and technonology to enhance travel experiences in Northern Ontario.

# Project Overview
Passport to The North is an innovative mobile application designed to boost tourism and promote cultural heritage in Northern Ontario. This app combines interactive maps, and a reward-based system to engage users in exploring the region. By integrating technology and gamification, the app offers an immersive experience that highlights hidden gems and supports the local economy.

# Core Objective
The project aims to promote Northern Ontario's tourism and cultural heritage by motivating users to explore, complete location-based tasks, and earn achievements. By blending technology with real-world exploration, Passport to The North serves as both a guide and a game, encouraging users to discover hidden gems and contribute to the local economy.

# Technologies Used
- ![Flutter Logo](assets/flutter.png)**Flutter**: The mobile app is developed using Flutter, a popular framework for building natively compiled applications for mobile from a single codebase. 
- ![Dart Logo](assets/dart.png)**Dart**: The programming language used for writing the app's code. Dart is optimized for building mobile, desktop, and web applications.
- ![Firebase Logo](assets/firebase.png)**Firebase**: The app uses Firebase for authentication, cloud storage, and Firestore as the database to manage user data and app content securely.
- **Firebase Cloud Messaging (FCM)**: For sending push notifications to users to keep them updated on achievements, task completions, and other notifications.
- **flutter_local_notifications**: For creating in-app notifications to alert users about various updates within the app.

## End Results

### 1. User Authentication & Profile Management
- Successfully integrated secure authentication using **JWT** and **Firebase**.
- Developed RESTful APIs for:
  - Login and Sign-up.
  - Password reset functionality.
  - Profile management.
- Implemented a user-friendly interface for easy navigation through these features.

### 2. Home Page & Navigation
- Designed and implemented the **Home Page** with essential features.
- Developed a navigation bar to connect different sections of the app seamlessly.

### 3. Storing Data in Cloud
- Successfully implemented cloud storage using **Firebase** and **Firestore** for secure data management.

### 4. Reward & Achievement System
- Building backend logic to:
  - Track user progress.
  - Unlock achievements dynamically based on activity.
- Designing a dynamic UI using tools like **Rive** or **Lottie** to display badges, progress bars, and reward animations.

### 5. Daily Challenges & Streaks
- Creating a special dashboard to:
  - Display daily and weekly challenges.
  - Track user streaks and reset them when needed.
- Ensuring compatibility for offline updates and progress tracking.

### 6. Alarm & Notification System
- Setting up **Firebase Cloud Messaging (FCM)** for push notifications:
  - Notify users of task completion.
  - Alert users about achievements and updates.
- Creating in-app notifications using **flutter_local_notifications**.

### 7. Enhanced UI/UX
- Refining the app’s design with:
  - Animated transitions and progress updates.
  - A modern, engaging interface for all features.

## Installation

### Prerequisites
1. **Flutter**: Make sure you have Flutter installed on your system.
2. **Firebase Account**: Set up Firebase for both authentication and Firestore database.

### Steps:
1. Clone this repository:
    ```bash
    git clone https://github.com/repository-link
    ```
2. Navigate to the project directory:
    ```bash
    cd passport-to-the-north
    ```
3. Install the dependencies:
    ```bash
    flutter pub get
    ```
4. Set up Firebase and configure the app according to the official documentation.

5. Run the app:
    ```bash
    flutter run
    ```
# Collaborators
- **Gurnoor Kaur** (A00287615)
- **Tsunami Karki** (A00286582)
- **Keshab Pathak** (A00295473)
- **Nabin Chhetri** (A00291016)