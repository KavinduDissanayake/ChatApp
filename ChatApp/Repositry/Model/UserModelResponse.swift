//
//  UserModelResponse.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-15.
//

import Foundation


// MARK: - UserModelResponse
struct UserModelResponse: Codable {
    let message: String?
    let payload: User?
}
