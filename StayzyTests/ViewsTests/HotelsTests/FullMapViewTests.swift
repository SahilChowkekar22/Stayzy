//
//  FullMapViewTests.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import XCTest
import ViewInspector
import MapKit
@testable import Stayzy

final class FullMapViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
            ViewHosting.expel()
        }

        func test_mapLoadsWithCorrectCoordinates() throws {
            // Given
            let coord = CLLocationCoordinate2D(latitude: 34.1808, longitude: -84.0809)
            let view = FullMapView(coordinate: coord)

            ViewHosting.host(view: view)

            // When
            let map = try view.inspect().find(ViewType.Map.self)

            // Then
            XCTAssertNotNil(map)
        }

        func test_dismissButtonExists() throws {
            let view = FullMapView(
                coordinate: CLLocationCoordinate2D(latitude: 34.0, longitude: -118.0)
            )

            ViewHosting.host(view: view)

            let button = try view.inspect().find(ViewType.Button.self)
            let image = try button.labelView().image().actualImage()

            XCTAssertEqual(try image.name(), "xmark.circle.fill")
        }

}
