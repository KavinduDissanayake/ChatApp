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

                Text("12:00 PM")
                    .font(.customFont(.DMSansRegular, 12))
            }
            
            
          
        }//:HStack
        .padding(.horizontal,16)
    }
    
    func messageView(message:Message,bodyType:MessageTypes) -> AnyView?{
        switch bodyType {
        case .text:
            return AnyView(TextMessageView(message: message))
        case .image:
            return AnyView(TextMessageView(message: message))
        case .pdf:
            return AnyView(PDFMessageView(message:message))
        case .location:
            return AnyView(LocationMessageView(message:message,isSender: false))
            
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
