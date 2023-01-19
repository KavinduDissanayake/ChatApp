//
//  RootView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-23.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var router: ViewRouter
    @State var isAnimated = false
    
    var body: some View {
        NavigationStack {
            containedView(roots: router.currentRoot)
                .id(UUID().uuidString)
                .transition(.slide).animation(.linear(duration: 0.2), value: isAnimated)
                .onAppear() {
                    DispatchQueue.main.async {
                        isAnimated = true
                    }
                }
 
        }//:NavigationView
    }
    
    func containedView(roots: Roots) -> AnyView {
        switch router.currentRoot {
        case .initialScreen:
            return AnyView(MainTabView())
        case .signup:
            return AnyView(MainTabView())
        case .signIn:
            return AnyView(LoginView())
        case .userTabs:
            return AnyView(MainTabView())
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(ViewRouter.shared)
    }
}
