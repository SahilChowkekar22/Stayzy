//
//  StayzyApp.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/21/25.
//
import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
@main
struct StayzyApp: App {
    // register app delegate for Firebase setup
     @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
//                        MainTabView()
////            NavigationStack {
////                SignInView()
////            }
            FirstScreenView()
        }
    }
}
