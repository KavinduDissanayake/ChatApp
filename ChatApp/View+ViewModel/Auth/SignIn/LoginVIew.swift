//
//  LoginVIew.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-06.
//

import SwiftUI

struct LoginView: View {
    
    //MARK: - PROPERITY
    @StateObject var vm = LoginViewVM()
    @State var isActiveSignUp = false
    @State var isActiveFP = false
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
                                              .shadow(color: grayColor, radius: 6,y:1)

                                        VStack(alignment:.center) {
                                              
                                                 Text("Sign In")
                                                .font(.customFont(.RalewayBold, 24))
                                               
                                            TextFiledInput(name: "Email", isValidation: Validators().isValidEmailValidator(value:  vm.emailText).isSuccess, keyboard: .emailAddress, isValidationRuntime: $vm.emailValidation, textFiled: $vm.emailText)
                                            //MARK: - VALIDATIONS
                                            .validate(with: vm.emailText, validation: Validators().isValidEmailValidator)
                                            
                                            TextFiledPasswordNew(name: "Password", isValidation: $vm.passwordValidation, textFiled: $vm.passwordText)
                                            //MARK: - VALIDATIONS
                                            .validate(with: vm.passwordText, validation: Validators().isValidPasswordValidator)
                                            
                                            HStack{
                                                Spacer()
                                                
                                                Text("Forgot Password?")
                                                    .font(.customFont(.RalewaySemiBold, 14))
                                                    .foregroundColor(themeColor)
                                                    .onTapGesture{
                                                        isActiveFP.toggle()
                                                    }
                                            }
                                            .padding(.vertical,20)
                                            
                                            LargeButton(title: "Sign In",backgroundColor: themeColor) {
                                                loginRequest()
                                               }
                                              .padding(.top,18)
                                            
                                            Spacer()
                                         
                                          }
                                        .padding(.all,16)
                                        
                                      }
                                      .frame(height:  geometry.size.height*0.4)
                                      .padding(.all,16)
                                      .padding(.vertical,20)
                                   
                                   
                                   
                               
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
                                   .onTapGesture{
                                       isActiveSignUp.toggle()
                                   }
                                   .padding(.bottom,35)
                                   .padding(.top,20)
                                 
                                   
                                    
                                   
                               }
                               .frame(minHeight: geometry.size.height)
                           }//:ScrollView
                           .frame(width: geometry.size.width)
                       }//:GeometryReader
                       
                   }//:VStack
                   
                    
                    Text("")
                       .navigationDestination(isPresented: $isActiveFP) {
                        ForgotPassword()
                       }
                    
            
                    Text("")
                       .navigationDestination(isPresented: $isActiveSignUp) {
                         SignUp()
                       }
            //MARK: - ALERT
            CustomAlert(isShowAlert: $vm.isShowAlert, alertTitle: vm.alertTitle, alertMessage:vm.alertMessage)
            
               }//:ZStack
               .navigationBarHidden(true)
               .edgesIgnoringSafeArea(.all)
    }
    
    
    func loginRequest(){
        startLoading()
        vm.loginRequest { status in
        stopLoading()
            if status {
                ViewRouter.shared.currentRoot =  .userTabs
            }
        }
    }
}

struct LoginVIew_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
//kavindu@gmail.com
//12345678k
