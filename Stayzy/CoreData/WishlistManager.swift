//
//  WishlistManager.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import CoreData
import SwiftUI


class WishlistManager: ObservableObject {
    static let shared = WishlistManager()
    private let viewContext = PersistenceController.shared.container.viewContext

    @Published var wishlistedHotels: [FavoriteHotel] = []

    init() {
        fetchFavorites()
    }

    func fetchFavorites() {
        let request: NSFetchRequest<FavoriteHotel> = FavoriteHotel.fetchRequest()
        wishlistedHotels = (try? viewContext.fetch(request)) ?? []
    }

    func isWishlisted(_ hotel: HotelElement) -> Bool {
        let request: NSFetchRequest<FavoriteHotel> = FavoriteHotel.fetchRequest()
        request.predicate = NSPredicate(format: "code == %d", hotel.code)
        let count = (try? viewContext.count(for: request)) ?? 0
        return count > 0
    }

    func toggle(hotel: HotelElement, price: String, rating: String) {
        if isWishlisted(hotel) {
            remove(hotel)
        } else {
            add(hotel, price: price, rating: rating)
        }
        fetchFavorites()
    }

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

    func remove(_ hotel: HotelElement) {
        let request: NSFetchRequest<FavoriteHotel> = FavoriteHotel.fetchRequest()
        request.predicate = NSPredicate(format: "code == %d", hotel.code)
        if let results = try? viewContext.fetch(request),
           let objectToDelete = results.first {
            viewContext.delete(objectToDelete)
            try? viewContext.save()
        }
    }
    
    func removeByFavorite(_ favHotel: FavoriteHotel) {
        viewContext.delete(favHotel)
        try? viewContext.save()
    }
    
    func clearAll() {
        wishlistedHotels.removeAll()
    }

}
