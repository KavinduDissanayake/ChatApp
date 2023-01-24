//
//  ForgotPassword.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-22.
//

import SwiftUI

struct ForgotPassword: View {
    var body: some View {
        ZStack {
            
            
                backgroundColor
            
                   VStack{
                       
                       
                       AuthHeader()
                       
                       GeometryReader { geometry in
                           
                           ScrollView(.vertical , showsIndicators: false) {
                               VStack(alignment: .center, spacing: 20) {
                                  // Spacer()
                                
                                    ZStack {
                                        
                                          RoundedRectangle(cornerRadius: 15, style: .continuous)
                                              .fill(cardColor)
                                              .shadow(color: grayColor, radius: 6,y:1)

                                        VStack(alignment:.center) {
                                              
                                            HStack {
                                             
                                                 Text("Reset Password")
                                                    .font(.customFont(.RalewayBold, 24))
                                             
                                            }
                                            
                                            
                                            Text("A password reset link was sent to your email address. Please check your email and try again.")
                                                .font(.customFont(.DMSansRegular, 15))
                                                .padding(.vertical,10)
                                               
                                            TextFiledInput(name: "Email", isValidation: true, keyboard: .default, isValidationRuntime: .constant(false), textFiled: .constant(""))
                                            
                                          
                                        
                                          
                                            LargeButton(title: "Reset Password",backgroundColor: themeColor) {
                                                
                                              
                                               }
                                              .padding(.top,18)
                                            
                                          
                                         
                                          }
                                        .padding(.all,16)
                                        
                                      }
                                      .frame(height:  geometry.size.height*0.4)
                                      .padding(.all,16)
                                    //  .padding(.vertical,20)
                                   
                                   
                                   
                               
                              
                                    Spacer()
                                    
                                   
                               }
                               .frame(minHeight: geometry.size.height)
                           }//:ScrollView
                           .frame(width: geometry.size.width)
                       }//:GeometryReader
                   }//:VStack
                   
            
            //MARK: - ALERT
          //  CustomAlert(isShowAlert: $vm.isShowAlert, alertTitle: vm.alertTitle, alertMessage:vm.alertMessage)
                       
               }//:ZStack
               .navigationBarHidden(true)
               .edgesIgnoringSafeArea(.all)
    }
}

struct ForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPassword()
    }
}
