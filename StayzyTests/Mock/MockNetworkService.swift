//
//  MockNetworkService.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import Foundation
@testable import Stayzy

class MockNetworkService: NetworkServiceProtocol {
    var mockData: Data?
    var shouldFail = false
    var statusCode: Int = 200

    func fetchData<T: Decodable>(from request: URLRequest) async throws -> T {
        if shouldFail {
            throw NetworkError.requestFailed(message: "Mock Failure")
        }

        guard statusCode >= 200 && statusCode <= 299 else {
            throw NetworkError.serverError(statusCode: statusCode)
        }

        guard let data = mockData else {
            throw NetworkError.invalidResponse(statusCode: -1)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Mock Decoding Error:", error)
            throw NetworkError.decodingError
        }
    }
}
