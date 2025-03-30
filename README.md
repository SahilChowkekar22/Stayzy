# Stayzy - Hotel Booking App

Stayzy is a modern iOS application that helps users find and book hotels with ease. Built with SwiftUI and following MVVM architecture, it offers a seamless and intuitive user experience for hotel bookings.

## 🌟 Features

- **User Authentication**
  - Sign In with Email/Password
  - Sign Up with Email/Password
  - Social Media Login (Google, Facebook, Apple)
  - Secure authentication flow
  - Password recovery

- **Hotel Search & Booking**
  - Advanced hotel search with filters
  - Detailed hotel information
  - Real-time availability checking
  - Secure booking process
  - Price comparison
  - Location-based search
  - Map integration

- **User Profile Management**
  - Personal information management
  - Booking history
  - Saved preferences
  - Wishlist functionality
  - Profile customization
  - Notification settings

- **Trip Management**
  - View upcoming trips
  - Trip details and itinerary
  - Booking modifications
  - Trip sharing
  - Trip reminders
  - Digital boarding pass

## 🛠 Technical Stack

- **Framework**: SwiftUI
- **Architecture**: MVVM (Model-View-ViewModel)
- **Language**: Swift
- **Database**: CoreData
- **Authentication**: Firebase Auth
- **Testing**: XCTest, SwiftUI Preview
- **Local Storage**: CoreData
- **Network Layer**: Custom implementation
- **UI Components**: Custom SwiftUI components

## 📱 Screenshots

[Add your app screenshots here]

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

3. Install dependencies (if any)
```bash
pod install
```

4. Set up Firebase
   - Add your `GoogleService-Info.plist` to the project
   - Configure Firebase in your project settings

5. Build and run the project

## 📋 Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+
- CocoaPods (if using)
- Firebase account
- Google Maps API key (for map features)

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

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- Your Name - Initial work

## 🙏 Acknowledgments

- [Firebase](https://firebase.google.com/)
- [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- [CoreData](https://developer.apple.com/documentation/coredata)
- [Google Maps](https://developers.google.com/maps)

## 📞 Support

For support, email support@stayzy.com or join our Slack channel.

---

Made with ❤️ by [Your Name] 