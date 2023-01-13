//
//  ApplicationServiceProvider.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-06.
//

import UIKit
let ASP = ApplicationServiceProvider.self

class ApplicationServiceProvider {
    
    static let shared = ApplicationServiceProvider()
    
    let bundleId = Bundle.main.bundleIdentifier ?? ""
    let deviceId = UIDevice.current.identifierForVendor!.uuidString
    let deviceType = "APPLE"
    let accept = "application/json"
    
}

extension ApplicationServiceProvider {
    
    public func getInitialAuthParameters() ->[String: Any] {
        return  [
            "Accept": "application/json",
            "device_id": ASP.shared.deviceId,
            "device_type": ASP.shared.deviceType,
            "device_token": "",
            "x-api-key":123456789
        ]
    }
}
