//
//  MainTabView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-23.
//

import SwiftUI

struct MainTabView: View {
    
    @State var selectedIndex: Int = 0
    
    var body: some View {
        CustomTabView(tabs: TabType.allCases.map({ $0.tabItem }), selectedIndex: $selectedIndex) { index in
            let type = TabType(rawValue: index) ?? .mychat
            getTabView(type: type)
        }.onAppear{
            print("selectedIndex\(selectedIndex)")
        }
    }
    
    @ViewBuilder
    func getTabView(type: TabType) -> some View {
        switch type {
        case .mychat:
            ChatList()
        case .mytask:
            ContactList()
        case .verifyed:
            HomePage()
        case .profile:
            Profile()
        }
    }
}


struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
