//
//  SecretsManager.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import Foundation

enum SecretsManager {
    static var apiKey: String {
        getSecret("HOTEL_API_KEY")
    }

    static var apiSecret: String {
        getSecret("HOTEL_SECRET")
    }

    private static func getSecret(_ key: String) -> String {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let value = dict[key] as? String else {
            fatalError("🚨 Missing secret for key: \(key)")
        }
        return value
    }
}
