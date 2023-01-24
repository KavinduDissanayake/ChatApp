//
//  SenderTextMessageCellView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-26.
//

import SwiftUI

struct SenderTextMessageCellView: View {
    var message:Message

    var body: some View {
        HStack(alignment:.top) {
            Spacer(minLength: 100)

            VStack(alignment:.trailing) {
                messageView(message: message, bodyType: message.type)
                HStack {
                    
                    Text(message.getMessageTime())
                        .font(.customFont(.DMSansRegular, 12))
                    
                     Image("ic_sent")
                        .resizable()
                        .frame(width: 18,height: 18)
                        .foregroundColor(message.isSeen ? themeColor :  nil)
                       
                }
            }
            
         }//:HStack
        .padding(.horizontal,16)
    }
    
    func messageView(message:Message,bodyType:MessageTypes) -> AnyView?{
        switch bodyType {
        case .text:
            return AnyView(TextMessageView(message: message))
        case .image:
            return AnyView(ImageMessageView(message: message))
        case .pdf:
            return AnyView(PDFMessageView(message:message))
        case .location:
            return AnyView(LocationMessageView(message:message))
            
        }
        
    }
}

struct SenderTextMessageCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            chatBackgroundColor
            SenderTextMessageCellView(message: dumyMessage)
        }
    }
}
