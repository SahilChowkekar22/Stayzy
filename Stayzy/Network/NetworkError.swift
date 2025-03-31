//
//  NetworkError.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/24/25.
//

import Foundation

// Enum to define custom network errors
enum NetworkError: Error, LocalizedError, Equatable {

    case invalidURL
    case requestFailed(message: String)
    case invalidResponse(statusCode: Int)
    case serverError(statusCode: Int)
    case noData
    case decodingError

    // Descriptions for displaying error messages
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL. Please check the endpoint."
        case .requestFailed(let message):
            return "Network request failed: \(message)"
        case .invalidResponse(let statusCode):
            return "Unexpected response: HTTP \(statusCode)"
        case .serverError(let statusCode):
            return "Server error occurred: HTTP \(statusCode)"
        case .noData:
            return "No data returned from server."
        case .decodingError:
            return "Failed to decode the server response."
        }
    }

    // Equatable conformance to compare error cases (useful in tests)
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.invalidResponse(let a), .invalidResponse(let b)):
            return a == b
        case (.serverError(let a), .serverError(let b)):
            return a == b
        case (.noData, .noData):
            return true
        case (.decodingError, .decodingError):
            return true
        case (.requestFailed(let a), .requestFailed(let b)):
            return a == b
        default:
            return false
        }
    }

}
