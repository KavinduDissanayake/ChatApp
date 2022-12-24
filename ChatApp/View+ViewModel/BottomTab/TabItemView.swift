//
//  TabItemView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-23.
//

import SwiftUI

struct TabItemView: View {
    let data: TabItemData
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Image(data.image)
                .resizable()
//                .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .frame(width: 28, height: 28)
              .animation(.default)
                .padding()
                   .background( isSelected ? themeColor :  nil )
                   .cornerRadius(8)
            
        }
    }
}


struct TabItemView_Previews: PreviewProvider {
    static var previews: some View {
        TabItemView(data: TabItemData(image: "ic_home",title: ""), isSelected: false)
            .previewLayout(.sizeThatFits)
    }
}




struct TabBottomView: View {
    
    let tabbarItems: [TabItemData]
    var height: CGFloat = 70
    var width: CGFloat = UIScreen.main.bounds.width - 32
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack {
            Spacer()
            
            ForEach(tabbarItems.indices) { index in
                let item = tabbarItems[index]
                Button {
                    self.selectedIndex = index
                } label: {
                    let isSelected = selectedIndex == index
                    TabItemView(data: item, isSelected: isSelected)
                }
                Spacer()
            }
        }
        .frame(width: width, height: height)
        .background(Color.white)
        .cornerRadius(13)
        .shadow(radius: 5, x: 0, y: 4)
    }
}


struct CustomTabView<Content: View>: View {
    
    let tabs: [TabItemData]
    @Binding var selectedIndex: Int
    @ViewBuilder let content: (Int) -> Content
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedIndex) {
                ForEach(tabs.indices) { index in
                    content(index)
                        .tag(index)
                }
            }
            
            VStack {
                Spacer()
                TabBottomView(tabbarItems: tabs, selectedIndex: $selectedIndex)
            }
            .padding(.bottom, 8)
        }
    }
}


enum TabType: Int, CaseIterable {
    case home = 1
    case myFile
    case profile
    
    var tabItem: TabItemData {
        switch self {
        case .home:
            return TabItemData(image: "ic_home",title: "Home")
        case .myFile:
            return TabItemData(image: "ic_chat", title: "Chat")
        case .profile:
            return TabItemData(image: "ic_user",title: "Profile")
        }
    }
}
