//
//  SecretsManager.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import Foundation

// Centralized utility for securely accessing API keys and secrets from Info.plist
enum SecretsManager {
    
    // Computed property to access the Hotelbeds API Key
    static var apiKey: String {
        getSecret("HOTEL_API_KEY")
    }

    // Computed property to access the Hotelbeds API Secret
    static var apiSecret: String {
        getSecret("HOTEL_SECRET")
    }

    // helper function to fetch a value from Info.plist
    private static func getSecret(_ key: String) -> String {
        // Locate the Info.plist file in the main bundle
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let value = dict[key] as? String else {
            fatalError("Missing secret for key: \(key)")
        }
        return value
    }
}
