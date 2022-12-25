//
//  Font+Extensions.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-24.
//

import SwiftUI


enum ChatAppFonts: String {
    case DMSansBold = "DMSans-Bold"
    case DMSansMedium = "DMSans-Medium"
    case DMSansRegular = "DMSans-Regular"
    case RalewayBold = "Raleway-Bold"
    case RalewaySemiBold = "Raleway-SemiBold"
}

extension Font {
    static func customFont( _ name: ChatAppFonts, _ size: CGFloat) -> Font {
        return Font.custom(name.rawValue, size: size)
    }
}
