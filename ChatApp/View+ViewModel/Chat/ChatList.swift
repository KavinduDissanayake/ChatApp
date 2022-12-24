//
//  ChatList.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-23.
//

import SwiftUI
struct ChatList: View {
    var body: some View {
        ZStack {
            // colorBackground
            VStack{
                GeometryReader { geometry in
                    ScrollView(.vertical , showsIndicators: false) {
                        VStack(alignment: .center, spacing: 20) {
                            
                            Text("TodayView")
                            
                        }//:VStack
                        .frame(minHeight: geometry.size.height)
                    }//:ScrollView
                    .frame(width: geometry.size.width)
                }//:GeometryReader
            }//:VStack
            
        }//:ZStack
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList()
    }
}
