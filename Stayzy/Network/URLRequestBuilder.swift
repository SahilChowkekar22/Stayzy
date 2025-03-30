//
//  URLRequestBuilder.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import Foundation

struct URLRequestBuilder {
    private var components: URLComponents
    private var headers: [String: String] = [:]

    init(endpoint: String) throws {
        guard let urlComponents = URLComponents(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        self.components = urlComponents
    }

    func addQueryItems(_ items: [(String, String)]) -> Self {
        var builder = self
        builder.components.queryItems = items.map { URLQueryItem(name: $0.0, value: $0.1) }
        return builder
    }

    func addHeaders(_ headers: [String: String]) -> Self {
        var builder = self
        builder.headers = headers
        return builder
    }

    func build() throws -> URLRequest {
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        return request
    }
}

