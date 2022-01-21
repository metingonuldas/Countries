//
//  CountryListRepsonse.swift
//  AlamofireTest
//
//  Created by Metin Kaan Gönüldaş on 20.01.2022.
//

import Foundation

// MARK: - Countries
struct Countries: Codable {
    let data: [Country]
    let links: [Link]
    let metadata: Metadata
}

// MARK: - Datum
struct Country: Codable {
    let code: String
    let currencyCodes: [String]
    let name, wikiDataID: String

    enum CodingKeys: String, CodingKey {
        case code, currencyCodes, name
        case wikiDataID = "wikiDataId"
    }
}

// MARK: - Link
struct Link: Codable {
    let rel, href: String
}

// MARK: - Metadata
struct Metadata: Codable {
    let currentOffset, totalCount: Int
}
