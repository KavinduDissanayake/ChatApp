//
//  Media.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-19.
//

import Foundation

struct Media: Codable {
    var sourceURL: String
    enum CodingKeys: String, CodingKey {
        case sourceURL = "source_url"
    }
}
