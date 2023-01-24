//
//  TextMessageView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-06.
//

   import SwiftUI

   struct TextMessageView: View {
       var message:Message
       var isSender = true
       
       var body: some View {
           Text(message.message)
               .font(.customFont(.DMSansRegular, 14))
               .padding(12)
               .background(isSender ? cardColor :themeColor)
               .foregroundColor(isSender ? nil : whiteColor)
               .cornerRadius(5, corners: .allCorners)
       }
   }

    struct TextMessageView_Previews: PreviewProvider {
        static var previews: some View {
            TextMessageView(message:dumyMessage)
                .previewLayout(.sizeThatFits)
        }
    }


