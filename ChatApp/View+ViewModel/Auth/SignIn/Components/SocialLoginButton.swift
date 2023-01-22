//
//  SocialLoginButton.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-06.
//

import SwiftUI

struct SocialLoginButton: View {
    //MARK: - PROPERITY
    var image:String
    var action: (() -> ())
    //MARK: - BODY
    var body: some View {
        Button(action: {
            //action
            action()
        }, label: {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44 )
                .shadow(color: grayColor, radius: 5,y:1)
            }
       )
    }
}
//MARK: - PREVIEW
struct SocialLoginButton_Previews: PreviewProvider {
    static var previews: some View {
        SocialLoginButton(image: "ic_login_google" ,action: {})
            .previewLayout(.sizeThatFits)
    }
}
