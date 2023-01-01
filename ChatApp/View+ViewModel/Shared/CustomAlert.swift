//
//  CustomAlert.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-01.
//

import SwiftUI

struct CustomAlert: View {
    //MARK: - PROPERITY
    @Binding var isShowAlert:Bool
    var alertTitle:String
    var alertMessage:String
    var action: (() -> ())?
    
    var body: some View {
        ZStack {
            
            
            if isShowAlert {
                // faded background
                Color.black.opacity(0.75)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0){
                    
                    // alert title
                    Text(alertTitle)
                        .font(.customFont(.RalewayBold, 15))
                        .foregroundColor( Color(UIColor.label))
                        .multilineTextAlignment(.center)
                        .frame(height: 25)
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 16)
                    
                    // alert message
                    Text(alertMessage)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .font(.customFont(.DMSansRegular, 14))
                        .foregroundColor( Color(UIColor.label))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                        .minimumScaleFactor(0.5)
                    
                    
                    
                    Divider()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0.5)
                        .padding(.all, 0)
                    
                    
                    HStack(spacing: 0) {
                        
                        // left button
                        Button {
                            action?()
                        } label: {
                            Text("Ok")
                                .font(.customFont(.RalewayBold, 16))
                                .foregroundColor( Color(UIColor.label))
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                        Divider()
                            .frame(minWidth: 0, maxWidth: 0.5, minHeight: 0, maxHeight: .infinity)
                        
                        // right button (default)
                        Button {
                            isShowAlert.toggle()
                        } label: {
                            Text("Cancel")
                                .font(.customFont(.RalewayBold, 16))
                                .foregroundColor(redColor)
                                .multilineTextAlignment(.center)
                                .padding(15)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                    }//:HStack
                    
                    
                    
                }
                .frame(width: 270, height: 150)
                .background(
                    cardColor
                )
                .cornerRadius(4)
                
            }
        }//:ZStack
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(isShowAlert: .constant(true), alertTitle: "Alert Titel", alertMessage:"In publishing and graphic design,")
    }
}
