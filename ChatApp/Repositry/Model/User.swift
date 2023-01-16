//
//  User.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-15.
//

import Foundation

// MARK: - Payload
struct User: Codable {
    var id: Int?
    var name, email, twoFactorSecret, twoFactorRecoveryCodes: String?
    var dob, gender, address, createdAt: String?
    var updatedAt, phone, deviceToken, deviceID: String?
    var deletedAt, lastSeen: String?
    var isOnline: Bool?
    var roles: String?
    var avatarURL: String?
    var accessToken: String?
    
    init(id: Int? = nil, name: String? = nil, email: String? = nil, twoFactorSecret: String? = nil, twoFactorRecoveryCodes: String? = nil, dob: String? = nil, gender: String? = nil, address: String? = nil, createdAt: String? = nil, updatedAt: String? = nil, phone: String? = nil, deviceToken: String? = nil, deviceID: String? = nil, deletedAt: String? = nil, lastSeen: String? = nil, isOnline: Bool? = nil, roles: String? = nil, avatarURL: String? = nil, accessToken: String? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.twoFactorSecret = twoFactorSecret
        self.twoFactorRecoveryCodes = twoFactorRecoveryCodes
        self.dob = dob
        self.gender = gender
        self.address = address
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.phone = phone
        self.deviceToken = deviceToken
        self.deviceID = deviceID
        self.deletedAt = deletedAt
        self.lastSeen = lastSeen
        self.isOnline = isOnline
        self.roles = roles
        self.avatarURL = avatarURL
        self.accessToken = accessToken
    }
}
