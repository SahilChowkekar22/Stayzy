//
//  NetworkServiceTests.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import XCTest
@testable import Stayzy

final class NetworkServiceTests: XCTestCase {

    var mockService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
    }

    override func tearDown() {
        mockService = nil
        super.tearDown()
    }

    struct MockResponse: Codable, Equatable {
        let message: String
    }

    // Success Case

    func test_fetchData_successfullyReturnsDecodedObject() async throws {
        // Given
        let mockObject = MockResponse(message: "Hello, Sahil!")
        mockService.mockData = try JSONEncoder().encode(mockObject)

        let request = URLRequest(url: URL(string: "https://mockurl.com")!)

        // When
        let result: MockResponse = try await mockService.fetchData(from: request)

        // Then
        XCTAssertEqual(result, mockObject)
    }

    // Request Failure Simulation
    func test_fetchData_failsWithRequestFailedError() async {
        // Given
        mockService.shouldFail = true
        let request = URLRequest(url: URL(string: "https://mockurl.com")!)

        do {
            let _: MockResponse = try await mockService.fetchData(from: request)
            XCTFail("Expected to throw, but succeeded")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .requestFailed(message: "Mock Failure"))
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    // Server Error Simulation (e.g. 500)
    func test_fetchData_failsWithServerError() async {
        // Given
        mockService.statusCode = 500
        let request = URLRequest(url: URL(string: "https://mockurl.com")!)

        do {
            let _: MockResponse = try await mockService.fetchData(from: request)
            XCTFail("Expected server error, but succeeded")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .serverError(statusCode: 500))
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    // Decoding Failure Simulation
    func test_fetchData_failsWithDecodingError() async {
        // Given
        // Invalid JSON for MockResponse
        mockService.mockData = """
        { "unexpected": "value" }
        """.data(using: .utf8)

        let request = URLRequest(url: URL(string: "https://mockurl.com")!)

        do {
            let _: MockResponse = try await mockService.fetchData(from: request)
            XCTFail("Expected decoding error, but succeeded")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .decodingError)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    // No Data Provided
    func test_fetchData_failsWithNoData() async {
        // Given
        mockService.mockData = nil
        let request = URLRequest(url: URL(string: "https://mockurl.com")!)

        do {
            let _: MockResponse = try await mockService.fetchData(from: request)
            XCTFail("Expected no data error, but succeeded")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .invalidResponse(statusCode: -1))
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
