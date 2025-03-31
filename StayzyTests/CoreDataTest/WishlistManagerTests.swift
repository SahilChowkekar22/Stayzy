//
//  WishlistManagerTests.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/31/25.
//

import XCTest
@testable import Stayzy
import CoreData

final class WishlistManagerTests: XCTestCase {
    var wishlistManager: WishlistManager!
    var mockHotel: HotelElement!
    var inMemoryContainer: NSPersistentContainer!

    // MARK: - Setup: Initialize in-memory Core Data & WishlistManager before each test
    override func setUp() {
        super.setUp()

        // 🔥 Set up an in-memory Core Data stack to isolate test data
        inMemoryContainer = NSPersistentContainer(name: "LocalStorage") // Match your actual .xcdatamodeld name
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        inMemoryContainer.persistentStoreDescriptions = [description]

        // Wait for Core Data to load completely before running tests
        let loadExpectation = expectation(description: "Core Data stack loaded")
        inMemoryContainer.loadPersistentStores { _, error in
            XCTAssertNil(error)
            loadExpectation.fulfill()
        }
        wait(for: [loadExpectation], timeout: 1.0)

        // Inject in-memory context into WishlistManager
        wishlistManager = WishlistManager(context: inMemoryContainer.viewContext)
        mockHotel = HotelElement.mock
    }

    // MARK: - Teardown: Cleanup after each test
    override func tearDown() {
        wishlistManager.clearAll()
        wishlistManager = nil
        mockHotel = nil
        inMemoryContainer = nil
        super.tearDown()
    }

    // MARK: - Test: Add a hotel and verify it's in the wishlist
    func test_addHotel_shouldAppearInWishlistedHotels() {
        // GIVEN
        wishlistManager.add(mockHotel, price: "$420", rating: "⭐️ 4.5")
        wishlistManager.fetchFavorites()

        // THEN
        XCTAssertTrue(wishlistManager.wishlistedHotels.contains {
            $0.code == Int64(mockHotel.code)
        }, "Hotel should be in wishlist after adding")
    }

    // MARK: - Test: Remove a hotel and verify it's no longer in the wishlist
    func test_removeHotel_shouldNotAppearInWishlistedHotels() {
        // GIVEN
        wishlistManager.add(mockHotel, price: "$420", rating: "⭐️ 4.5")
        wishlistManager.fetchFavorites()

        // WHEN
        wishlistManager.remove(mockHotel)
        wishlistManager.fetchFavorites()

        // THEN
        XCTAssertFalse(wishlistManager.wishlistedHotels.contains {
            $0.code == Int64(mockHotel.code)
        }, "Hotel should not be in wishlist after removal")
    }

    // MARK: - Test: Toggle wishlist status and verify behavior
    func test_toggle_shouldAddOrRemoveBasedOnState() {
        // WHEN: Toggling first time → adds
        wishlistManager.toggle(hotel: mockHotel, price: "$420", rating: "⭐️ 4.5")
        XCTAssertTrue(wishlistManager.isWishlisted(mockHotel))

        // WHEN: Toggling again → removes
        wishlistManager.toggle(hotel: mockHotel, price: "$420", rating: "⭐️ 4.5")
        XCTAssertFalse(wishlistManager.isWishlisted(mockHotel))
    }

    // MARK: - Test: Clear all hotels and ensure list is empty
    func test_clearAll_shouldEmptyWishlistedHotelsArray() {
        // GIVEN
        wishlistManager.add(mockHotel, price: "$420", rating: "⭐️ 4.5")
        wishlistManager.fetchFavorites()
        XCTAssertFalse(wishlistManager.wishlistedHotels.isEmpty)

        // WHEN
        wishlistManager.clearAll()

        // THEN
        XCTAssertTrue(wishlistManager.wishlistedHotels.isEmpty)
    }

    // MARK: - Test: Remove hotel by Core Data object reference
    func test_removeByFavorite_shouldDeleteCorrectObject() {
        // GIVEN
        wishlistManager.add(mockHotel, price: "$420", rating: "⭐️ 4.5")
        wishlistManager.fetchFavorites()

        // WHEN
        guard let fav = wishlistManager.wishlistedHotels.first else {
            return XCTFail("No favorite hotel found to remove.")
        }

        wishlistManager.removeByFavorite(fav)
        wishlistManager.fetchFavorites()

        // THEN
        XCTAssertTrue(wishlistManager.wishlistedHotels.isEmpty)
    }
}
