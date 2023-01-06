//
//  LoginVIew.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-06.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack {
            
            
                backgroundColor
          // Color.red
            
                   VStack{
                       
                       GeometryReader { geometry in
                           
                           ScrollView(.vertical , showsIndicators: false) {
                               VStack(alignment: .center, spacing: 20) {
                                   Spacer()
                                   Image("Icon_placeholder")
                                       .resizable()
                                       .frame(width: 100,height: 100)
                                   
                                   
                                    ZStack {
                                        
                                          RoundedRectangle(cornerRadius: 15, style: .continuous)
                                              .fill(cardColor)
                                              .shadow(color: grayColor, radius: 16,y:2)

                                        VStack(alignment:.center) {
                                              
                                                 Text("Sign In")
                                                .font(.customFont(.RalewayBold, 24))
                                               
                                                TextFiledInput(name: "User Name", isValidation:  true, keyboard: .emailAddress, isValidationRuntime: .constant(true), textFiled: .constant(""))
                                                .padding(.vertical,10)
                                            
                                            
                                                TextFiledInput(name: "User Name", isValidation:  true, keyboard: .emailAddress, isValidationRuntime: .constant(true), textFiled: .constant(""))
                                             
                                          
                                            
                                            HStack{
                                                Spacer()
                                                
                                                Text("Forgot Password?")
                                                    .font(.customFont(.RalewaySemiBold, 14))
                                                    .foregroundColor(themeColor)
                                            }
                                            .padding(.vertical,20)
                                            
                                            LargeButton(title: "Sign In",
                                                        backgroundColor: themeColor) {
                                                                    print("Hello World")
                                                                }
                                                        .padding(.top,18)
                                            
                                            Spacer()
                                         
                                          }
                                        .padding(.all,16)
                                        
                                      }
                                      .frame(height:  geometry.size.height*0.4)
                                      .padding(.all,16)
                                   
                                   
                                   
                               
                                   Spacer()
                                   
                                   Text("Or continue with")
                                       .font(.customFont(.DMSansRegular, 14))
                                       .padding(.top, 25)
                                       .foregroundColor(grayColor)
                                   
                                   
                                   HStack(spacing:10){
                                       
                                       SocialLoginButton(image: "ic_login_apple" ,action: {
                                           
                                       })
                                       
                                       SocialLoginButton(image: "ic_login_google" ,action: {
                                           
                                       })
                                       
                                       SocialLoginButton(image: "ic_login_facebook" ,action: {
                                           
                                       })
                                       
                                       
                                       
                                      
                                       
                                       
                                   }//:HStack
                                   
                                   VStack{
                                       
                                       Text("Don't have an account? ")
                                           .font(.customFont(.DMSansMedium, 14))
                                           .foregroundColor(grayColor)
                                          + Text("Sign Up")
                                           .font(.customFont(.RalewayBold, 14))
                                           .foregroundColor(themeColor)
                                   }
                                   .padding(.bottom,35)
                                   .padding(.top,20)
                                 
                                   
                                    
                                   
                               }
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

struct LoginVIew_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}