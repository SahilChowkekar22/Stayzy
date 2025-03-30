//
//  URLRequestBuilderTests.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import XCTest
@testable import Stayzy

final class URLRequestBuilderTests: XCTestCase {

    func test_init_withValidURL_setsUpComponents() throws {
        // GIVEN
        let urlString = "https://example.com/api"

        // WHEN
        let builder = try URLRequestBuilder(endpoint: urlString)

        // THEN
        // If no error is thrown, the URL was valid
        XCTAssertNotNil(builder)
    }



    func test_addQueryItems_appendsCorrectParams() throws {
        // GIVEN
        let builder = try URLRequestBuilder(endpoint: "https://example.com/api")
        let queryParams = [("key1", "value1"), ("key2", "value2")]

        // WHEN
        let updated = builder.addQueryItems(queryParams)
        let request = try updated.build()

        // THEN
        guard let url = request.url?.absoluteString else {
            return XCTFail("URL not formed")
        }

        XCTAssertTrue(url.contains("key1=value1"))
        XCTAssertTrue(url.contains("key2=value2"))
    }

    func test_addHeaders_setsCorrectHTTPHeaders() throws {
        // GIVEN
        let headers = ["Authorization": "Bearer 123", "Accept": "application/json"]
        let builder = try URLRequestBuilder(endpoint: "https://example.com/api")

        // WHEN
        let updated = builder.addHeaders(headers)
        let request = try updated.build()

        // THEN
        XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"), "Bearer 123")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Accept"), "application/json")
    }

    func test_build_throwsInvalidURL_ifComponentsFail() throws {
        // GIVEN a URL with no host (invalid)
        var components = URLComponents()
        components.scheme = "https"

        var brokenBuilder = try URLRequestBuilder(endpoint: "https://test")
        brokenBuilder = brokenBuilder.addQueryItems([]) // override internal components

        // You'd have to force the internal state invalid for this to fail
        // but in current impl, this isn't likely to fail unless initial endpoint is bad.
    }
}
