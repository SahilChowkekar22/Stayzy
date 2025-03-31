//
//  HotelAPIService.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/25/25.
//

import CryptoKit
import Foundation

// Protocol defining the hotel API interface for abstraction and testability
protocol HotelAPIServiceProtocol {
    func fetchHotelList() async throws -> [HotelElement]
    func fetchHotelDetail(hotelCode: Int) async throws -> HotelDetail
}

// Concrete implementation of HotelAPIServiceProtocol
struct HotelAPIService: HotelAPIServiceProtocol {
    private let apiKey: String
    private let secret: String
    private let network: NetworkServiceProtocol

    // Default initializer with dependency injection for API credentials and networking
    init(
        apiKey: String = SecretsManager.apiKey,
        secret: String = SecretsManager.apiSecret,
        network: NetworkServiceProtocol = NetworkService()
    ) {
        self.apiKey = apiKey
        self.secret = secret
        self.network = network
    }

    // Fetch a list of hotels using the hotel list API endpoint
    func fetchHotelList() async throws -> [HotelElement] {
        // Build the URL request with required query parameters and headers
        let request = try URLRequestBuilder(endpoint: APIEndpoint.hotelList)
            .addQueryItems([
                ("fields", "all"),
                ("language", "ENG"),
                ("from", "1"),
                ("to", "100"),
                ("useSecondaryLanguage", "false"),
            ])
            .addHeaders(headers)
            .build()

        // Make the network call and decode the response
        let response: HotelListResponse = try await network.fetchData(
            from: request)
        return response.hotels ?? []
    }

    // Fetch detailed information for a specific hotel by hotel code
    func fetchHotelDetail(hotelCode: Int) async throws -> HotelDetail {
        // Build the URL request with hotel-specific parameters
        let request = try URLRequestBuilder(
            endpoint: APIEndpoint.hotelDetail(hotelCode: hotelCode)
        )
        .addQueryItems([
            ("language", "ENG"),
            ("useSecondaryLanguage", "false"),
        ])
        .addHeaders(headers)
        .build()

        // Make the network call and decode the detail response
        return try await network.fetchData(from: request)
    }
}

// Auth Header Extension
extension HotelAPIService {
    // Compute the required API headers including a time-based signature
    fileprivate var headers: [String: String] {
        let timestamp = String(Int(Date().timeIntervalSince1970))  // Current UNIX timestamp
        let raw = apiKey + secret + timestamp  // Concatenate for hashing
        let hash = SHA256.hash(data: Data(raw.utf8))  // Generate SHA256 hash
        let signature = hash.map { String(format: "%02x", $0) }.joined()  // Convert hash to hex string

        return [
            "Api-Key": apiKey,
            "X-Signature": signature,
            "Accept": "application/json",
        ]
    }
}
