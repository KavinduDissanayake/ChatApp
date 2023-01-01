//
//  ButtonOutLineWithImage.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-01.
//

import SwiftUI

struct ButtonOutLineWithImage: View {
    var imageName: String
    var title: String
    var action: (() -> ())
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Spacer()
                Image(imageName)
                    .resizable()
                    .frame(width: 24,height: 24)
                //  .foregroundColor(themeColor)
                Text(title)
                    .font(.customFont(.DMSansBold, 14))
                //.foregroundColor(themeColor)
                Spacer()
            }
            .padding(.all,15)//:HStack
            .foregroundColor( Color(UIColor.label))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray.opacity(0.5), lineWidth: 1)
            )
            .frame(height:60)
            .padding(.horizontal,20)
            .padding(.vertical,2)
        }
    }
}


struct ButtonOutLineWithImage_Previews: PreviewProvider {
    static var previews: some View {
        ButtonOutLineWithImage(imageName: "ic_pdf", title: "PDf", action: {})
    }
}
