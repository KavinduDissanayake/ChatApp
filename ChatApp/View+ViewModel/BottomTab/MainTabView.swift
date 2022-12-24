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
            let type = TabType(rawValue: index) ?? .home
            getTabView(type: type)
        }
    }
    
    @ViewBuilder
    func getTabView(type: TabType) -> some View {
        switch type {
        case .home:
            
            ChatList()
            //HomePage()
        case .myFile:
            HomePage()
        case .profile:
            HomePage()
        }
    }
}


struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
