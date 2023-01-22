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
    case signIn
    case userTabs
}


class ViewRouter: ObservableObject {
    
    @Published var currentRoot: Roots =  .signup
    
    static let shared = ViewRouter()

    fileprivate init() {
        
        if PersistenceController.shared.loadUserData()?.accessToken != nil {
            currentRoot = .userTabs
        }
      
    }
    
}

