//
//  WishlistManager.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import SwiftUI
import CoreData

// WishlistProtocol
// A protocol that defines the core operations for a hotel wishlist repository.
protocol WishlistProtocol: ObservableObject {
    
    // An array of all wishlisted hotels (stored in Core Data or mocked).
    var wishlistedHotels: [FavoriteHotel] { get set }

    // Load the favorites from storage (e.g., Core Data).
    func fetchFavorites()

    // Toggle wishlist status — adds if not present, removes if already wishlisted.
    func toggle(hotel: HotelElement, price: String, rating: String)

    // Check if a given hotel is already in the wishlist.
    func isWishlisted(_ hotel: HotelElement) -> Bool

    // Remove a hotel from the wishlist by its FavoriteHotel Core Data object.
    func removeByFavorite(_ favHotel: FavoriteHotel)

    // Clear the in-memory cache of wishlisted hotels (not necessarily Core Data).
    func clearAll()
}

// WishlistWrapper
// A wrapper class that bridges any WishlistProtocol conformer into an ObservableObject
// so it can be used with SwiftUI’s @StateObject/@ObservedObject.
class WishlistWrapper: ObservableObject {

    // Private Properties

    // The injected repository that performs the actual data operations (Core Data, mock, etc.)
    private let repository: any WishlistProtocol

    // Published Data
    
    // The local observable array that SwiftUI views can bind to.
    @Published var wishlistedHotels: [FavoriteHotel] = []

    // Init
    
    // Initializes the wrapper with a protocol-based repository (dependency injected).
    init(repository: any WishlistProtocol) {
        self.repository = repository
        self.wishlistedHotels = repository.wishlistedHotels
    }

    // Public Interface (bridging to repository)

    // Fetches favorites from the data source and updates the published array.
    func fetchFavorites() {
        repository.fetchFavorites()
        wishlistedHotels = repository.wishlistedHotels
    }

    // Toggles the wishlist status for a given hotel and syncs state.
    func toggle(hotel: HotelElement, price: String, rating: String) {
        repository.toggle(hotel: hotel, price: price, rating: rating)
        wishlistedHotels = repository.wishlistedHotels
    }

    // Removes a specific FavoriteHotel object and updates the view state.
    func removeByFavorite(_ favHotel: FavoriteHotel) {
        repository.removeByFavorite(favHotel)
        wishlistedHotels = repository.wishlistedHotels
    }

    // Clears all favorites (from memory only) and updates the UI.
    func clearAll() {
        repository.clearAll()
        wishlistedHotels = []
    }

    // Checks if a given hotel is wishlisted (delegates to repository).
    func isWishlisted(_ hotel: HotelElement) -> Bool {
        repository.isWishlisted(hotel)
    }
}


// WishlistManager manages hotel favorites using Core Data
class WishlistManager: ObservableObject, WishlistProtocol {
    static let shared = WishlistManager()
    
    private let viewContext: NSManagedObjectContext
    
    // Reference to Core Data context
//    private let viewContext = PersistenceController.shared.container.viewContext

    @Published var wishlistedHotels: [FavoriteHotel] = []

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
            self.viewContext = context
            fetchFavorites()
        }
    
    // Fetch all wishlisted hotels from Core Data
    func fetchFavorites() {
        let request: NSFetchRequest<FavoriteHotel> = FavoriteHotel.fetchRequest()
        wishlistedHotels = (try? viewContext.fetch(request)) ?? []
    }
    
    // Check if a hotel is already wishlisted based on its unique code
    func isWishlisted(_ hotel: HotelElement) -> Bool {
        let request: NSFetchRequest<FavoriteHotel> = FavoriteHotel.fetchRequest()
        request.predicate = NSPredicate(format: "code == %d", hotel.code)
        let count = (try? viewContext.count(for: request)) ?? 0
        return count > 0
    }

    // Toggle wishlist status: add if not present, remove if already wishlisted
    func toggle(hotel: HotelElement, price: String, rating: String) {
        if isWishlisted(hotel) {
            remove(hotel)
        } else {
            add(hotel, price: price, rating: rating)
        }
        fetchFavorites()
    }

    // Add a hotel to Core Data and wishlist
    func add(_ hotel: HotelElement, price: String, rating: String) {
        let fav = FavoriteHotel(context: viewContext)
        fav.code = Int64(hotel.code)
        fav.name = hotel.name?.content ?? "Unnamed Hotel"
        fav.city = hotel.city?.content ?? "Unknown"
        fav.state = hotel.state?.name
        fav.price = price
        fav.rating = rating
        fav.imageURL = hotel.images?.first?.path ?? ""
        try? viewContext.save()
    }

    // Remove a hotel from Core Data based on its code
    func remove(_ hotel: HotelElement) {
        let request: NSFetchRequest<FavoriteHotel> = FavoriteHotel.fetchRequest()
        request.predicate = NSPredicate(format: "code == %d", hotel.code)
        if let results = try? viewContext.fetch(request),
           let objectToDelete = results.first {
            viewContext.delete(objectToDelete)
            try? viewContext.save()
        }
    }
    
    // Remove a specific FavoriteHotel object from Core Data
    func removeByFavorite(_ favHotel: FavoriteHotel) {
        viewContext.delete(favHotel)
        try? viewContext.save()
    }
    
    // Clear the local list of wishlisted hotels (does not affect Core Data)
    func clearAll() {
        wishlistedHotels.removeAll()
    }

}
