//
//  RootView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-23.
//

import SwiftUI

struct RootView: View {
    
    @StateObject var router: ViewRouter
     
     var body: some View {
       Group {
           containedView(roots: router.currentRoot)
        }
     }
    
    func containedView(roots: Roots) -> AnyView {
        switch router.currentRoot {
            case .initialScreen:
                   return AnyView(MainTabView())
                
            case .signup:
                   return AnyView(MainTabView())
                
            case .userTabs:
                   return AnyView(MainTabView())
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(router: ViewRouter.shared)
    }
}
