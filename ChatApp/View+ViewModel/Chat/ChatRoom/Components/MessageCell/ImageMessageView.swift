//
//  ImageMessageView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-06.
//

import SwiftUI
import SDWebImageSwiftUI


struct ImageMessageView: View {
    
    var message:Message
    var isSender = true
    var body: some View {
       
        VStack{
            
            WebImage(url: URL(string: "https://ui-avatars.com/api/?name=John+Doe"))

        }//:VStack
        .padding(5)
        .background(isSender ? cardColor :themeColor)
        .foregroundColor(isSender ? nil : whiteColor)
        .cornerRadius(12)
        .frame(width: 180)
        .frame(height: 130)
    }
}

struct ImageMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageMessageView(message:dumyMessage,isSender: false)
    }
}
