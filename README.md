# Stayzy - Hotel Booking App

Stayzy is a modern iOS application that helps users find and book hotels with ease. Built with SwiftUI and following MVVM architecture, it offers a seamless and intuitive user experience for hotel bookings.

## 🌟 Features

- **User Authentication**
  - Sign In with Email/Password
  - Sign Up with Email/Password
  - Social Media Login (Google, Facebook, Apple)
  - Secure authentication flow
  - Password recovery
  - Session management

- **Hotel Search & Booking**
  - Advanced hotel search with filters
  - Detailed hotel information
  - Real-time availability checking
  - Secure booking process
  - Price comparison
  - Location-based search
  - Map integration
  - Hotel reviews and ratings

- **User Profile Management**
  - Personal information management
  - Booking history
  - Saved preferences
  - Wishlist functionality
  - Profile customization
  - Notification settings
  - Payment methods management

- **Trip Management**
  - View upcoming trips
  - Trip details and itinerary
  - Booking modifications
  - Trip sharing
  - Trip reminders
  - Digital boarding pass
  - Trip cancellation

## 🛠 Technical Stack

### Core Technologies
- **Framework**: SwiftUI
- **Language**: Swift 5.5+
- **Architecture**: MVVM (Model-View-ViewModel)
- **iOS Target**: iOS 15.0+

### Backend & Data
- **Authentication**: Firebase Auth
  - Email/Password authentication
  - Social media sign-in (Google, Facebook, Apple)
  - Secure session management
- **Database**: 
  - CoreData for local storage
  - Firebase Firestore for cloud data
- **File Storage**: Firebase Storage
- **Analytics**: Firebase Analytics

### UI/UX
- **UI Framework**: SwiftUI
- **Custom Components**: 
  - Custom search bar
  - Rating components
  - Hotel cards
  - Booking forms
- **Design System**:
  - Custom color scheme
  - Typography system
  - Component library

### Networking
- **API Layer**: Custom implementation
  - RESTful API integration
  - JSON parsing
  - Error handling
  - Request/Response caching
- **Maps Integration**: Google Maps SDK
- **Image Loading**: Async image loading with caching

### Development Tools
- **Version Control**: Git
- **Dependency Management**: Swift Package Manager
- **Testing**:
  - XCTest for unit testing
  - SwiftUI Preview for UI testing
  - UI tests for critical flows
- **Code Quality**:
  - SwiftLint for code style
  - SwiftFormat for formatting
  - Code coverage tracking

### Performance & Optimization
- **Caching**: 
  - CoreData for local data
  - Image caching
  - API response caching
- **Memory Management**: ARC
- **Background Processing**: Background tasks and fetch

### Security
- **Authentication**: Firebase Auth
- **Data Encryption**: 
  - Secure storage for sensitive data
  - HTTPS for network calls
- **Input Validation**: Custom validation rules

## 📱 Screenshots

### Authentication Flow
<img src="Stayzy/Images/Login.png" width="300" height="600" alt="Sign In">
<img src="Stayzy/Images/SignUp.png" width="300" height="600" alt="Sign Up">
<img src="Stayzy/Images/FirstScreen.png" width="300" height="600" alt="First Screen">

### Main Features
<img src="Stayzy/Images/Explore.png" width="300" height="600" alt="Explore">
<img src="Stayzy/Images/HotelDetail.png" width="300" height="600" alt="Hotel Details">
<img src="Stayzy/Images/HotelDescription.png" width="300" height="600" alt="Hotel Description">

### Maps & Location
<img src="Stayzy/Images/Map.png" width="300" height="600" alt="Map View">
<img src="Stayzy/Images/FullMap.png" width="300" height="600" alt="Full Map">

### User Profile & Trips
<img src="Stayzy/Images/profile.png" width="300" height="600" alt="Profile">
<img src="Stayzy/Images/ProfileInfo.png" width="300" height="600" alt="Profile Info">
<img src="Stayzy/Images/Trips.png" width="300" height="600" alt="Trips">
<img src="Stayzy/Images/Wishlists.png" width="300" height="600" alt="Wishlists">
<img src="Stayzy/Images/Messages.png" width="300" height="600" alt="Messages">

## 🔧 Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/Stayzy.git
```

2. Open the project in Xcode
```bash
cd Stayzy
open Stayzy.xcodeproj
```

3. Install dependencies
```bash
# Using Swift Package Manager
# Dependencies are automatically managed by Xcode
```

4. Set up Firebase
   - Add your `GoogleService-Info.plist` to the project
   - Configure Firebase in your project settings
   - Enable required Firebase services (Auth, Firestore, etc.)

5. Configure CoreData
   - Ensure `LocalStorage.xcdatamodeld` is properly set up
   - Run initial migration if needed

6. Build and run the project

## 📋 Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+
- Firebase account
- Google Maps API key (for map features)
- CoreData setup

## 🏗 Project Structure

```
Stayzy/
├── App/
│   └── App configuration and setup
├── Views/
│   ├── Authentication/
│   │   ├── SignInView
│   │   ├── SignUpView
│   │   └── FirstScreenView
│   ├── Profile/
│   │   ├── ProfileView
│   │   └── ProfileInfoView
│   ├── Trips/
│   │   └── TripsView
│   └── Components/
│       ├── SearchBar
│       └── WishlistHeartButton
├── ViewModel/
│   └── Business logic and state management
├── Models/
│   └── Data models and entities
├── Network/
│   └── API communication layer
├── CoreData/
│   └── Local database configuration
├── Repository/
│   └── Data access layer
├── Utils/
│   └── Helper functions and extensions
└── Resources/
    └── Assets and configuration files
```

## 🧪 Testing

The project includes comprehensive unit tests and UI tests:

```bash
# Run unit tests
xcodebuild test -scheme Stayzy -destination 'platform=iOS Simulator,name=iPhone 14'

# Run UI tests
xcodebuild test -scheme Stayzy -destination 'platform=iOS Simulator,name=iPhone 14' -only-testing:StayzyUITests
```

### Test Coverage
- Authentication flows
- Hotel search functionality
- Booking process
- User profile management
- Trip management
- UI components
- Network layer
- CoreData operations
- Repository layer
- ViewModel logic

