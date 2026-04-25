# 🚀 TotalX User Management App

A Flutter application built as part of the TotalX assignment.
The app allows users to authenticate using Google Sign-In and manage user data efficiently with search, filtering, and image upload features.

---

## 📱 Features

### 🔐 Authentication

* Google Sign-In using Firebase Authentication

### 👤 User Management

* Add user with:

  * Name
  * Age
  * Phone Number
  * Profile Image (from gallery)
* Image upload using Firebase Storage

### 🔍 Search

* Search users by:

  * Name
  * Phone Number

### 🔄 Sorting / Filtering

* Filter users by age:

  * Above 60 → Older
  * Below 60 → Younger

### 📍 Location

* Fetch and display current location using Geolocator
* Handles:

  * Permission request
  * GPS disabled state
  * Redirect to settings

### ⚡ Lazy Loading (Pagination)

* Loads users in batches
* Fetches more data on scroll
* Optimized performance

---

## 🧱 Architecture

The app follows a **clean modular architecture**:

```text
UI (Screens + Widgets)
        ↓
Controller
        ↓
Provider (State Management)
        ↓
Services (Firebase / Location)
```

### State Management

* Provider

### Architecture Pattern

* MVC-inspired modular structure

---

## 📁 Project Structure

```text
lib/
├── controllers/
├── models/
├── provider/
├── services/
├── ui/
│   ├── screens/
│   └── widget/
```

---

## 🛠️ Tech Stack

* Flutter
* Dart
* Firebase Authentication
* Cloud Firestore
* Firebase Storage
* Provider (State Management)
* Geolocator & Geocoding

---

## 📦 APK Download

👉 The APK file is included in the submission.

---

## 🔗 GitHub Repository

👉 https://github.com/Asif-K-Ashraf/totalx_test

---

## ⚙️ Setup Instructions

1. Clone the repository:

```bash
git clone https://github.com/Asif-K-Ashraf/totalx_test.git
```

2. Navigate to project:

```bash
cd totalx_test
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

---

## 📌 Notes

* Ensure Firebase is configured properly
* Enable Google Sign-In in Firebase Console
* Allow location permissions when prompted

---

## 🙌 Author

**Asif K Ashraf**

---

## ⭐ Conclusion

This project demonstrates:

* Clean architecture
* Firebase integration
* Efficient state management
* Optimized UI/UX with lazy loading and background processing

---

✨ Thank you for reviewing!
