//
//  URLRequestBuilder.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import Foundation

// A builder struct for constructing URLRequest objects in a clean, modular way
struct URLRequestBuilder {
    // Stores the base URL components
    private var components: URLComponents
    
    // Stores HTTP headers to be applied to the request
    private var headers: [String: String] = [:]

    // Initializes the builder with an endpoint string and validates it
    init(endpoint: String) throws {
        guard let urlComponents = URLComponents(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        self.components = urlComponents
    }

    // Adds query parameters to the URL (e.g., ?key=value)
    func addQueryItems(_ items: [(String, String)]) -> Self {
        var builder = self
        builder.components.queryItems = items.map { URLQueryItem(name: $0.0, value: $0.1) }
        return builder
    }

    // Adds HTTP headers to the request (e.g., Content-Type, Authorization)
    func addHeaders(_ headers: [String: String]) -> Self {
        var builder = self
        builder.headers = headers
        return builder
    }

    // Builds and returns a URLRequest with the given URL and headers
    func build() throws -> URLRequest {
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        return request
    }
}

