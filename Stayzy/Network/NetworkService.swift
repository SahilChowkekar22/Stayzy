//
//  NetworkService.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/24/25.
//

import Foundation

//Protocol for network service abstraction
protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(from request: URLRequest) async throws -> T
}

// Concrete implementation using URLSession
struct NetworkService: NetworkServiceProtocol {
    
    // Generic method to fetch and decode data from a network request
    func fetchData<T: Decodable>(from request: URLRequest) async throws -> T {
        // Perform the network request using URLSession with async/await
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Ensure the response is an HTTPURLResponse
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse(statusCode: -1)
        }

        print("Status Code:", httpResponse.statusCode)

        // Check for successful HTTP status code (2xx)
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }

        // Attempt to decode the JSON response into the expected type
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Decoding Error:", error)
            throw NetworkError.decodingError
        }
    }
}
