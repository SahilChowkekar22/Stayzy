import FirebaseCore
//
//  StayzyApp.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/21/25.
//
import SwiftUI

// Custom AppDelegate class to handle Firebase initialization
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        // Configure Firebase when the app launches
        FirebaseApp.configure()

        return true
    }
}
@main
struct StayzyApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    // State to manage whether to show the launch screen or the main view
    @State private var showLaunchScreen = true

    var body: some Scene {
        WindowGroup {
            if showLaunchScreen {
                LaunchScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation {
                                showLaunchScreen = false
                            }
                        }
                    }
            } else {
                FirstScreenView()
            }
        }
    }
}
