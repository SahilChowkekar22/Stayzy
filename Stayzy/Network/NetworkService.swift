//
//  NetworkService.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/24/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(from request: URLRequest) async throws -> T
}

struct NetworkService: NetworkServiceProtocol {
    
    func fetchData<T: Decodable>(from request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse(statusCode: -1)
        }

        print("Status Code:", httpResponse.statusCode)

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Decoding Error:", error)
            throw NetworkError.decodingError
        }
    }
}
