//
//  DummyModel.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-25.
//

import Foundation


let dummyUse1 = User(id:2, name: "Test", email: nil ,twoFactorSecret:nil, twoFactorRecoveryCodes: nil, dob: nil, gender: nil, address: nil, createdAt: nil, updatedAt: nil, phone: nil, deviceToken: nil, deviceID: nil, deletedAt: nil, lastSeen: nil, isOnline: nil, roles: nil, avatarURL: nil, accessToken: nil)


let dummyUser2 = User(id:1, name: "Test", email: nil, twoFactorSecret:nil, twoFactorRecoveryCodes: nil, dob: nil, gender: nil, address: nil, createdAt: nil, updatedAt: nil, phone: nil, deviceToken: nil, deviceID: nil, deletedAt: nil, lastSeen: nil, isOnline: nil, roles: nil, avatarURL: nil, accessToken: nil)
 

let dumyMessage = Message(id: "1", idFrom: "1", idTo: "2", message: "Test", isSeen: false, type: .text, time: 0,media: Media(sourceURL: "https://i.pravatar.cc/"))
