//
//  Location.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-19.
//

import Foundation



struct Location: Codable {
    var locationName: String
    var latitude: String
    var longitude: String
    enum CodingKeys: String, CodingKey {
        case locationName = "locationName"
        case latitude = "latitude"
        case longitude = "longitude"
    }
}
