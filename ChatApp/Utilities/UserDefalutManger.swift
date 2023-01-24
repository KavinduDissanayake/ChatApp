//
//  UserDefalutManger.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-06.
//

import Foundation

public struct UserDefalutManger {
    
    public static let shared = UserDefaults.standard
    
    //MARK: Set FCM token
    public static func setFCMToken(token: String) {
        shared.set(token, forKey: "FCM_TOKEN")
        shared.synchronize()
    }
    
    //MARK: Get FCM token
    public static func getFCMToken() -> String {
        if let token = shared.string(forKey: "FCM_TOKEN") {
            return token
        }
        return ""
    }
    
    
}
