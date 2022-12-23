//
//  ViewRouter.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-23.
//

import SwiftUI


enum Roots {
    case initialScreen
    case signup
    case userTabs
}


class ViewRouter: ObservableObject {
    
    @Published var currentRoot: Roots =  .initialScreen
    
    static let shared = ViewRouter()

    fileprivate init() {
        currentRoot = .userTabs
    }
}

