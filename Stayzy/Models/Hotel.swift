//
//  Hotel.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/24/25.
//

import Foundation

// MARK: - Hotel
struct Hotel: Decodable {
    let code: Int?
    let name, description: City?
    let countryCode: CountryCode?
    let address: Address?
    let postalCode: String?
    let city: City?
    let images: [HotelImages]?
    let s2C: S2C?
    let ranking: Int?
}

struct HotelListResponse: Decodable {
    let hotels: [HotelElement]?
}

// MARK: - Address
struct Address:Decodable {
    let content, street, number: String?
    let floor, door: String?
}


// MARK: - City
struct City:Decodable {
    let content: String?
}

enum CountryCode: String,Decodable {
    case es
    case pt
}

// MARK: - Image
struct HotelImages:Decodable {
    let imageTypeCode: ImageTypeCode?
    let path: String?
    let order, visualOrder: Int?
    let roomCode: String?
    let roomType: RoomTypeEnum?
    let characteristicCode: String?
}

enum ImageTypeCode: String, Decodable {
    case bar = "BAR"
    case com = "COM"
    case con = "CON"
    case dep = "DEP"
    case gen = "GEN"
    case hab = "HAB"
    case pis = "PIS"
    case pla = "PLA"
    case res = "RES"
    case ter = "TER"
}

enum RoomTypeEnum: String, Decodable {
    case apt = "APT"
    case bed = "BED"
    case bun = "BUN"
    case cab = "CAB"
    case ctg = "CTG"
    case dbl = "DBL"
    case dbt = "DBT"
    case dus = "DUS"
    case fam = "FAM"
    case jsu = "JSU"
    case lod = "LOD"
    case qua = "QUA"
    case roo = "ROO"
    case sgl = "SGL"
    case stu = "STU"
    case sui = "SUI"
    case tpl = "TPL"
    case twh = "TWH"
    case twn = "TWN"
    case vil = "VIL"
}

enum S2C: String, Decodable {
    case the1 = "1*"
    case the2 = "2*"
    case the3 = "3*"
    case the4 = "4*"
    case the5 = "5*"
}
