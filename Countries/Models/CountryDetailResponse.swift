//
//  CountryDetailResponse.swift
//  AlamofireTest
//
//  Created by Metin Kaan Gönüldaş on 20.01.2022.
//

import Foundation

// MARK: - CountryDetail
struct CountryDetail: Codable {
    let data: CountryDetailClass
}

// MARK: - CountryDetailClass
struct CountryDetailClass: Codable {
    let capital, code, callingCode: String
    let currencyCodes: [String]
    let flagImageURI: String
    let name: String
    let numRegions: Int
    let wikiDataID: String

    enum CodingKeys: String, CodingKey {
        case capital, code, callingCode, currencyCodes
        case flagImageURI = "flagImageUri"
        case name, numRegions
        case wikiDataID = "wikiDataId"
    }
}
