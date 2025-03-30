//
//  HotelDetail.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/25/25.
//

import Foundation


struct HotelDetail: Decodable {
    let s2C: String?
    let address: AddressDetail?
    let city: AddressDetail?
    let country: Country?
    let description: AddressDetail?
    let destination: Destination?
    let destinationCode, email: String?
    let images: [ImageDetails]
    let name: AddressDetail?
    let phones: [PhoneDetails]?
    let postalCode, ranking: Int?
    let state: RegionState?
}

// MARK: - AccommodationType
struct AccommodationType: Decodable {
    let code, typeDescription: String?
    let typeMultiDescription: AddressDetail?
}

// MARK: - Address
struct AddressDetail: Decodable {
    let content, languageCode: String?
}

// MARK: - Coordinates
struct CoordinatesDetail: Decodable {
    let latitude, longitude: Double?
}

// MARK: - Country
struct Country: Decodable {
    let code: String?
    let description: AddressDetail?
    let isoCode: String?
    let states: [RegionState]?
}
// MARK: - State
struct RegionState: Decodable {
    let code, name: String?
}

// MARK: - Destination
struct Destination: Decodable {
    let code, countryCode: String?
    let groupZones: [GroupZone]?
    let isoCode: String?
    let name: AddressDetail?
    let zones: [Zone]?
}

// MARK: - GroupZone
struct GroupZone: Decodable {
    let groupZoneCode: String?
    let name: AddressDetail?
    let zones: [Int]?
}

// MARK: - Zone
struct Zone: Decodable {
    let description: AddressDetail?
    let name: String?
    let zoneCode: Int?
}

// MARK: - Facility
struct FacilityDetail: Decodable {
    let ageFrom, ageTo: Int?
    let amount: Double?
    let applicationType, currency, dateFrom, dateTo: String?
    let description: AddressDetail?
    let distance, facilityCode, facilityGroupCode: Int?
    let facilityName: String?
    let indFee, indLogic, indYesOrNo: Bool?
    let number, order: Int?
    let timeFrom, timeTo: String?
    let voucher: Bool?
}

// MARK: - Image
struct ImageDetails: Decodable {
    let characteristicCode, imageTypeCode: String?
    let order: Int?
    let path, roomCode, roomType: String?
    let type: TypeClass?
    let visualOrder: Int?
    let pmsRoomCode: String?
}

// MARK: - TypeClass
struct TypeClass: Decodable {
    let code: String?
    let description: AddressDetail?
}

// MARK: - Phone
struct PhoneDetails: Decodable {
    let phoneNumber: Int?
    let phoneType: String?
}

// MARK: - HotelElement
struct HotelElement: Decodable, Identifiable {
    let s2C: String?
    var id: Int { code }
    let code: Int
    let accommodationType: AccommodationType?
    let accommodationTypeCode: String?
    let address: AddressDetail?
    let city: AddressDetail?
    let coordinates: CoordinatesDetail?
    let country: Country?
    let description: AddressDetail?
    let facilities: [FacilityDetail]?
    let images: [HotelImages]?
    let name: AddressDetail?
    let postalCode: String?
    let ranking: Int?
    let state: RegionState?
}
