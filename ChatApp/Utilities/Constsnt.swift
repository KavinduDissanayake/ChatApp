//
//  Constsnt.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-25.
//

import SwiftUI

let mainScreenHieght = UIScreen.main.bounds.height
let mainScreenWidth = UIScreen.main.bounds.width


struct Constant {
    
    //MARK: Manage app environment with release type
    static let appEnvironment: DeploymentEnvironment = .development
    
    //MARK: App environments
    enum DeploymentEnvironment {
        case development
        case staging
        case production
    }
    
    //MARK: Get URLs (Base url etc.)
    enum URLs {
        static let baseUrl = getBaseURL()
    }
    
    
    //MARK: Provide base url for current app environment
    static func getBaseURL() -> String {
        switch Constant.appEnvironment {
        case .development:
            return "https://rathnaweera.silicontools.xyz/"
        case .staging:
            return ""
        case .production:
            return "https://"
        }
    }
    
}


