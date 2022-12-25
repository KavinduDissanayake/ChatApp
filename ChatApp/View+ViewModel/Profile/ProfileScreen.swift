//
//  ProfileScreen.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-25.
//

import SwiftUI


struct ProfileScreen: View {
        var body: some View {
    
            ZStack {
                backgroundColor
                VStack{
    
                    
                    //TODO: refactor ui later-----
                    ZStack{
                        Image("splash_bg_image")
                            .resizable()
                            .scaledToFill()
                            .frame(width: Double.infinity,height: 259)
                        
                        VStack(spacing:5) {
                        
                            Image("user")
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                            .stroke(grayColor, lineWidth: 2)
                                )
                            
                            Text("Kavindu Dissanayake")
                                .font(.customFont(.RalewaySemiBold, 18))
                                .foregroundColor(whiteColor)
                            Text("25 Years Old")
                                .font(.customFont(.DMSansRegular, 14))
                                .foregroundColor(whiteColor)
                        }
                        .padding(.top,30)
                       // .background(Color.red)
                      
                    }//;ZStack
                   .background(themeColor)
                   .cornerRadius(20)
                    
                  
                    
                    GeometryReader { geometry in
    
                        ScrollView(.vertical , showsIndicators: false) {
                            VStack(alignment: .center, spacing: 20) {
    
                                MenuItem(title: "My Profile")
                                
                                MenuItem(title: "Settings")
                                
                                MenuItem(title: "Change Password")
                                
                                MenuItem(title: "Privacy policy")

                                MenuItem(title: "Terms and conditions")

                              

                                MenuItem(title: "About us")
                                
                                MenuItem(title: "Logout ")

                               // Spacer()
                                VStack{
                                    
                                }.frame(height:10)
                                
                                LargeButton(title: "Invite a Friend",
                                            backgroundColor: cardColor,
                                            foregroundColor: themeColor) {
                                                        print("Hello World")
                                                    }
                                
//                                LargeButton(title: "Log out",
//                                            backgroundColor: themeColor) {
//                                                        print("Hello World")
//                                                    }
                               
                                Spacer()

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

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}



//struct TodayView: View {
//
//    var body: some View {
//
//        ZStack {
//            colorBackground
//
//            VStack{
//
//                GeometryReader { geometry in
//
//                    ScrollView(.vertical , showsIndicators: false) {
//                        VStack(alignment: .center, spacing: 20) {
//
//                            Text("TodayView")
//                        }//:VStack
//                        .frame(minHeight: geometry.size.height)
//                    }//:ScrollView
//                    .frame(width: geometry.size.width)
//                }//:GeometryReader
//            }//:VStack
//
//        }//:ZStack
//        .navigationBarHidden(true)
//        .edgesIgnoringSafeArea(.all)
//    }
//}
