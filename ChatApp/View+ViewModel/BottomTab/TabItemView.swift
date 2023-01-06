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
                .scaledToFit()
                .frame(width: isSelected ? 24 : 28,
                       height: isSelected ? 24 : 28
                )
               // .frame(width: <#T##CGFloat?#>)
                .animation(.default)
                .padding(.all ,8)
                .background( isSelected ? themeColor :  nil )
                .cornerRadius(8)
                .foregroundColor(grayColor)
              //  .padding()
              //  .padding( isSelected ? 10 :  0 )
            
        }
    }
}


struct TabItemView_Previews: PreviewProvider {
    static var previews: some View {
        TabItemView(data: TabItemData(image: "ic_home",title: ""), isSelected: true)
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
        .background(cardColor)
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
            // .background(Color.red)
            
            VStack {
                Spacer()
                TabBottomView(tabbarItems: tabs, selectedIndex: $selectedIndex)
            }
            .padding(.bottom, 8)
        }
    }
}


enum TabType: Int, CaseIterable {
    case mychat = 0
    case mytask
    case verifyed
    case profile
    
    
    var tabItem: TabItemData {
        switch self {
        case .mychat:
            return TabItemData(image: "ic_chat",title: "My Chat")
        case .mytask:
            return TabItemData(image: "ic_my_task", title: "mytask")
        case .verifyed:
            return TabItemData(image: "ic_verifyed", title: "verifyed")
        case .profile:
            return TabItemData(image: "ic_user",title: "Profile")
        }
    }
}
