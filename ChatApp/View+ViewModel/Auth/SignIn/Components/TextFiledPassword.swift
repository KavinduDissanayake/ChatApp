//
//  TextFiledPassword.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-06.
//

import Foundation

import SwiftUI


//MARK: - Validation will show when user hit the submit button
struct TextFiledPasswordNew: View {
    //MARK: - PROPERITY
    var name: String
    @Binding var isValidation :Bool
    //MARK: - Password
    @Binding var textFiled: String
    @State var isToggleOn = false
    
    //MARK: - BODY
    var body: some View {
        VStack(alignment:.leading,spacing: 0){
        
            
            HStack {
                
                Group{
                    if self.isToggleOn{
                        TextField("", text: $textFiled)
                            .autocapitalization(.none)
                            .font(.customFont(.DMSansMedium, 14))
                        //  .padding()
                        //  .font(ManropeMediumCustom(size: 14))
                            .onChange(of: textFiled, perform: { value in
                                // isShowingValidation = true
                                isValidation = false
                            })
                    }
                    else{
                        SecureField("", text: $textFiled)
                            .autocapitalization(.none)
                        // .padding()
                        //  .font(ManropeMediumCustom(size: 14))
                            .onChange(of: textFiled, perform: { value in
                                //  isShowingValidation = true
                                isValidation = false
                            })
                    }
                    
                }
                .placeholder(when: textFiled.isEmpty) {
                    Text(name
                    )  .font(.customFont(.DMSansMedium, 14)).foregroundColor(grayColor)
                    
                }
                .padding()
                if !isValidation {
                    
                    Button(action: {
                        self.isToggleOn.toggle()
                        
                    }, label: {
                        Image( self.isToggleOn ? "ic_eye_active" : "ic_eye_inactive")
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 20, height: 20)
                    })
                  
                } else {
                    Button(action: {
                        
                        //self.isToggleOn.toggle()
                     //MARK: - BUTTON FOR CLEAN TEXT FELED
                        if isValidation{
                            textFiled = ""
                        }
                        //
                        isValidation = false
                    }, label: {
                        Image( "ic_remove")
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 18, height: 18)
                    })
                   
                }
                Spacer()
                
            }//:HStack
           
            
            
            RoundedRectangle(cornerRadius: 2, style: .continuous)
                .fill(grayColor)
                .frame(height: 2)
        }//:VStack
     
       
    }
    
}


//MARK: - PROPERITY
struct TextFiledPasswordNew_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.yellow
            TextFiledPasswordNew(name: "Password", isValidation:.constant(true), textFiled: .constant(""))
                .previewLayout(.sizeThatFits)
            
        }
    }
}
