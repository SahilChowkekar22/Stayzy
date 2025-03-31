//
//  MockNetworkService.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import Foundation
@testable import Stayzy

// A mock implementation of `NetworkServiceProtocol` for unit testing.
// Simulates API responses and error conditions without real network calls.
class MockNetworkService: NetworkServiceProtocol {
    var mockData: Data?
    var shouldFail = false
    var statusCode: Int = 200

    // Simulated fetch function that either returns decoded mock data or throws a mock error.
    func fetchData<T: Decodable>(from request: URLRequest) async throws -> T {
        
        // Simulate generic failure
        if shouldFail {
            throw NetworkError.requestFailed(message: "Mock Failure")
        }

        // Simulate server-side error (like 404, 500, etc.)
        guard statusCode >= 200 && statusCode <= 299 else {
            throw NetworkError.serverError(statusCode: statusCode)
        }

        // Simulate missing data
        guard let data = mockData else {
            throw NetworkError.invalidResponse(statusCode: -1)
        }

        // Decode and return mock data
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Mock Decoding Error:", error)
            throw NetworkError.decodingError
        }
    }
}
