//
//  TextFiledInputNew.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-06.
//

import SwiftUI

struct TextFiledInput: View {
    
    //MARK: - PROPERITY
    var name: String
    var isValidation :Bool
    var keyboard: UIKeyboardType
    //MARK: - When user hit the submit button
    @Binding var isValidationRuntime :Bool
    //MARK: - textFiled
    @Binding var textFiled: String
    @State var isShowingValidation: Bool = false
    
    //MARK: - BODY
    var body: some View {
        VStack(alignment:.leading,spacing: 0){
            
            HStack {
                
                TextField("", text: $textFiled)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .keyboardType(keyboard)
                    .font(.customFont(.DMSansMedium, 14))
                    .onChange(of: textFiled, perform: { value in
                        isShowingValidation = true
                        //MARK: - To change error icon
                        isValidationRuntime = false
                        
                    })
                    .placeholder(when: textFiled.isEmpty) {
                        Text(name
                        )  .font(.customFont(.DMSansMedium, 14)).foregroundColor(.gray)
                        
                    }
                    .padding()
                        
                        if !isValidationRuntime {
                            
                            
                            if isShowingValidation {
                                
                                Button(action: {
                                    //MARK: - BUTTON FOR CLEAN TEXT FELED
                                    if !isValidation{
                                        textFiled = ""
                                    }
                                    
                                }, label: {
                                    
                                    
                                    Image( isValidation ? "ic_tick_inactive":"ic_remove")
                                        .resizable()
                                        .foregroundColor( isValidation ? themeColor : nil)
                                        .frame(width: 20, height: 20)
                                })
                                
                            }
                            
                            
                            
                        } else {
                            Button(action: {
                                
                                //self.isToggleOn.toggle()
                                //MARK: - BUTTON FOR CLEAN TEXT FELED
                                if isValidation{
                                    textFiled = ""
                                }
                                //
                                isValidationRuntime.toggle()
                                //isValidation.toggle()
                            }, label: {
                                Image( "ic_remove")
                                    .resizable()
                                    .foregroundColor(.gray)
                                    .frame(width: 20, height: 20)
                            })
                            // .padding()
                        }
                        
                        Spacer()
                    }
                
                
                
                RoundedRectangle(cornerRadius: 2, style: .continuous)
                    .fill(grayColor)
                    .frame(height: 2)
                
            }//:VStack
            
            .background(Color.white)
           
            
            
        }
    }
    
    
    //MARK: - PROPERITY
    struct TextFiledInputNew_Previews: PreviewProvider {
        static var previews: some View {
            
            ZStack{
                Color.yellow
                TextFiledInput(name: "User Name", isValidation:  true, keyboard: .emailAddress, isValidationRuntime: .constant(true), textFiled: .constant(""))
                    .previewLayout(.sizeThatFits)
                
            }
            
        }
    }
