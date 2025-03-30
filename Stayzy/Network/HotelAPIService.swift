//
//  HotelAPIService.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/25/25.
//

import CryptoKit
import Foundation

protocol HotelAPIServiceProtocol {
    func fetchHotelList() async throws -> [HotelElement]
    func fetchHotelDetail(hotelCode: Int) async throws -> HotelDetail
}

struct HotelAPIService: HotelAPIServiceProtocol {
    private let apiKey: String
    private let secret: String
    private let network: NetworkServiceProtocol

    init(
        apiKey: String = SecretsManager.apiKey,
        secret: String = SecretsManager.apiSecret,
        network: NetworkServiceProtocol = NetworkService()
    ) {
        self.apiKey = apiKey
        self.secret = secret
        self.network = network
    }

    func fetchHotelList() async throws -> [HotelElement] {
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

        let response: HotelListResponse = try await network.fetchData(
            from: request)
        return response.hotels ?? []
    }

    func fetchHotelDetail(hotelCode: Int) async throws -> HotelDetail {
        let request = try URLRequestBuilder(
            endpoint: APIEndpoint.hotelDetail(hotelCode: hotelCode)
        )
        .addQueryItems([
            ("language", "ENG"),
            ("useSecondaryLanguage", "false"),
        ])
        .addHeaders(headers)
        .build()

        return try await network.fetchData(from: request)
    }
}

// MARK: - Auth Header Extension
extension HotelAPIService {
    fileprivate var headers: [String: String] {
        let timestamp = String(Int(Date().timeIntervalSince1970))
        let raw = apiKey + secret + timestamp
        let hash = SHA256.hash(data: Data(raw.utf8))
        let signature = hash.map { String(format: "%02x", $0) }.joined()

        return [
            "Api-Key": apiKey,
            "X-Signature": signature,
            "Accept": "application/json",
        ]
    }
}
