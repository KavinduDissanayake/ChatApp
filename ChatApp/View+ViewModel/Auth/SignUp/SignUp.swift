//
//  SignUp.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-22.
//

import SwiftUI

struct SignUp: View {
    
    @State private var isChecked: Bool = false
    @State var isActiveSignIn = false

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
                                             
                                                 Text("Sign Up")
                                                    .font(.customFont(.RalewayBold, 24))
                                             
                                            }
                                               
                                            TextFiledInput(name: "First Name", isValidation: true, keyboard: .default, isValidationRuntime: .constant(false), textFiled: .constant(""))
                                            
                                            TextFiledInput(name: "Last Name", isValidation: true, keyboard: .emailAddress, isValidationRuntime: .constant(false), textFiled: .constant(""))
                                            
                                            
                                            TextFiledInput(name: "Email", isValidation: true, keyboard: .emailAddress, isValidationRuntime: .constant(false), textFiled: .constant(""))
                                            
                                    
                                            
                                            TextFiledPasswordNew(name: "Password", isValidation: .constant(false), textFiled: .constant(""))
                                            
                                            TextFiledPasswordNew(name: "Confirm Password", isValidation: .constant(false), textFiled: .constant(""))
                                            
                                        
                                            
                                            HStack {
                                                CheckBoxField(isMarked: $isChecked)
                                                
                                                Text("By submitting, You agree to our ")
                                                    .font(.customFont(.RalewayBold, 14))
                                                    .foregroundColor(grayColor)
                                                   + Text(" Terms & Conditions ")
                                                    .font(.customFont(.RalewayBold, 14))
                                                    .foregroundColor(themeColor)
                                                  +   Text("and")
                                                    .font(.customFont(.RalewayBold, 14))
                                                    .foregroundColor(grayColor)
                                                + Text(" Privacy Policy ")
                                                 .font(.customFont(.RalewayBold, 14))
                                                 .foregroundColor(themeColor)
                                                
                                            }
                                             
                                            .padding(.top,16)
                                        
                                           
                                            
                                            LargeButton(title: "Sign Up",backgroundColor: themeColor) {
                                                
                                              
                                               }
                                              .padding(.top,18)
                                            
                                          
                                         
                                          }
                                        .padding(.all,16)
                                        
                                      }
                                      //.frame(height:  geometry.size.height*0.7)
                                      .padding(.all,16)
                                    //  .padding(.vertical,20)
                                   
                                   
                                   
                               
                                //   Spacer()
                                   
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
                                       
                                       Text("Already have an account?")
                                           .font(.customFont(.DMSansMedium, 14))
                                           .foregroundColor(grayColor)
                                          + Text("Sign In")
                                           .font(.customFont(.RalewayBold, 14))
                                           .foregroundColor(themeColor)
                                   }
                                   .onTapGesture{
                                       isActiveSignIn.toggle()
                                   }
                                   .padding(.bottom,35)
                                   .padding(.top,20)
                                 
                                   
                                    
                                   
                               }
                               .frame(minHeight: geometry.size.height)
                           }//:ScrollView
                           .frame(width: geometry.size.width)
                       }//:GeometryReader
                   }//:VStack
                   
            
            //MARK: - ALERT
          //  CustomAlert(isShowAlert: $vm.isShowAlert, alertTitle: vm.alertTitle, alertMessage:vm.alertMessage)            
                         Text("")
                            .navigationDestination(isPresented: $isActiveSignIn) {
                              LoginView()
                            }
               }//:ZStack
               .navigationBarHidden(true)
               .edgesIgnoringSafeArea(.all)
    }
}

struct CheckboxStyle: ToggleStyle {

    func makeBody(configuration: Self.Configuration) -> some View {

        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .font(.system(size: 20, weight: .regular, design: .default))
                configuration.label
        }
        .onTapGesture { configuration.isOn.toggle() }

    }
}



struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
