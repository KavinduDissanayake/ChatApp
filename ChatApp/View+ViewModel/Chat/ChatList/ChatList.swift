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
            
            backgroundColor
            

            VStack{

                
                HeaderView(title: "Message")
                
                
                //TODO: refactor ui-----
                HStack {
                    TextField("Search ..", text:.constant(""))
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(grayColor)
                   }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                
                
                
                
                GeometryReader { geometry in
                    ScrollView(.vertical , showsIndicators: false) {
                        VStack(alignment: .center, spacing: 20) {
                            
                            ChatUserView(){
                                
                            }
                            
                            ChatUserView(){
                                
                            }
                            
                            ChatUserView(){
                                
                            }
                            
                            ChatUserView(){
                                
                            }
                            
                            
                            ChatUserView(){
                                
                            }
                            
                            
                            ChatUserView(){
                                
                            }
                            ChatUserView(){
                                
                            }
                            
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
