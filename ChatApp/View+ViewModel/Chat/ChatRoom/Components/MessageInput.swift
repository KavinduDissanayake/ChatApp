//
//  MessageInput.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-25.
//

import SwiftUI

struct MessageInput: View {
    var body: some View {
        HStack {
            
         HStack {
                TextField("Type her ..", text:.constant(""))
                    .font(.customFont(.DMSansRegular, 14))
                    .padding(.vertical,10)
                    .padding(.horizontal, 10)
                
                
                Image("icon")
                    .resizable()
                    .frame(width:22,height: 22)
                    .padding(.horizontal, 8)
                
            }//:HStack
            .overlay(
                
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 1)
                    .foregroundColor(grayColor)
                
            )
            
            Image("ic_nav_foward")
                .foregroundColor(whiteColor)
                .padding(6)
                .background(
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(themeColor)
                )
            
        }//:HStack
        .padding()
        .cornerRadius(8)
        .padding(.horizontal, 8)
        .background(cardColor)
    }
}

struct MessageInput_Previews: PreviewProvider {
    static var previews: some View {
        MessageInput()
            .previewLayout(.sizeThatFits)
    }
}
