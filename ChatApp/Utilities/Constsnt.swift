//
//  Constsnt.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-25.
//

import SwiftUI

let mainScreenHieght = UIScreen.main.bounds.height
let mainScreenWidth = UIScreen.main.bounds.width

struct Screen {
    
    static func sizeFromWidth(size: CGFloat) -> CGFloat {
        var width: CGFloat
        width = mainScreenWidth * size / 375
        return width
    }
    
    static func sizeFromHeight(size: CGFloat) -> CGFloat {
        var height: CGFloat
        height = mainScreenHieght * size / 667
        return height
    }
    
}


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
            return "https://rathnaweera.silicontools.xyz/api/v1"
        case .staging:
            return ""
        case .production:
            return "https://"
        }
    }
    
    static func getBaseURLV2() -> String {
        switch Constant.appEnvironment {
        case .development:
            return "https://rathnaweera.silicontools.xyz/api/v2"
        case .staging:
            return ""
        case .production:
            return "https://"
        }
    }
    
    
    static func getAPIKey() -> Int {
        switch Constant.appEnvironment {
        case .development:
            return 123456789
        case .staging:
            return 0
        case .production:
            return 0
        }
    }
    
}


