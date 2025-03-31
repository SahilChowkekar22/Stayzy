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

## 🔐 Authentication Flow
<table style="border: none;">
<tr>
<td style="border: none; text-align: center;">
<h3>Welcome Screen</h3>
<p><em>App introduction and login options</em></p>
<img src="Stayzy/Images/FirstScreen.png" width="200" height="400" alt="Welcome Screen">
</td>
<td style="border: none; text-align: center;">
<h3>Sign In Screen</h3>
<p><em>Email/Password login with social options</em></p>
<img src="Stayzy/Images/Login.png" width="200" height="400" alt="Sign In">
</td>
</tr>
<tr>
<td style="border: none; text-align: center;">
<h3>Sign Up Screen</h3>
<p><em>New user registration with validation</em></p>
<img src="Stayzy/Images/SignUp.png" width="200" height="400" alt="Sign Up">
</td>
<td style="border: none; text-align: center;">
<h3>Profile Information</h3>
<p><em>Edit personal details</em></p>
<img src="Stayzy/Images/ProfileInfo.png" width="200" height="400" alt="Profile Info">
</td>
</tr>
</table>

---

## ✨ Main Features
<table style="border: none;">
<tr>
<td style="border: none; text-align: center;">
<h3>Explore Screen</h3>
<p><em>Browse hotels with filters and search</em></p>
<img src="Stayzy/Images/Explore.png" width="200" height="400" alt="Explore">
</td>
<td style="border: none; text-align: center;">
<h3>Hotel Details</h3>
<p><em>Comprehensive hotel information</em></p>
<img src="Stayzy/Images/HotelDetail.png" width="200" height="400" alt="Hotel Details">
</td>
</tr>
<tr>
<td style="border: none; text-align: center;">
<h3>Hotel Description</h3>
<p><em>Detailed amenities and facilities</em></p>
<img src="Stayzy/Images/HotelDescription.png" width="200" height="400" alt="Hotel Description">
</td>
</tr>
</table>

---

## 🗺️ Maps & Location
<table style="border: none;">
<tr>
<td style="border: none; text-align: center;">
<h3>Map View</h3>
<p><em>Interactive hotel location map</em></p>
<img src="Stayzy/Images/Map.png" width="200" height="400" alt="Map View">
</td>
<td style="border: none; text-align: center;">
<h3>Full Map View</h3>
<p><em>Expanded map with all nearby hotels</em></p>
<img src="Stayzy/Images/FullMap.png" width="200" height="400" alt="Full Map">
</td>
</tr>
</table>

---

## 👤 User Profile & Trips
<table style="border: none;">
<tr>
<td style="border: none; text-align: center;">
<h3>Profile Screen</h3>
<p><em>User profile and settings</em></p>
<img src="Stayzy/Images/profile.png" width="200" height="400" alt="Profile">
</td>
<td style="border: none; text-align: center;">
<h3>Trips Screen</h3>
<p><em>View and manage bookings</em></p>
<img src="Stayzy/Images/Trips.png" width="200" height="400" alt="Trips">
</td>
</tr>
<tr>
<td style="border: none; text-align: center;">
<h3>Wishlists</h3>
<p><em>Saved hotels and favorites</em></p>
<img src="Stayzy/Images/Wishlists.png" width="200" height="400" alt="Wishlists">
</td>
<td style="border: none; text-align: center;">
<h3>Messages</h3>
<p><em>Booking notifications and support</em></p>
<img src="Stayzy/Images/Messages.png" width="200" height="400" alt="Messages">
</td>
</tr>
</table>

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

