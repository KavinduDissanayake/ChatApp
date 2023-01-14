//
//  ReceiveTextMessageCellView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-26.
//
import SDWebImageSwiftUI
import SwiftUI

struct ReceiveMessageCellView: View {
    
    
    @StateObject  var vm = ReceiveMessageCellVM()
    
    var message:Message
    
    
    var body: some View {
        HStack(alignment:.top) {
            
            WebImage(url: URL(string: vm.contactUser.avatarURL ?? ""))
                .onSuccess { image, data, cacheType in
                    DispatchQueue.main.async {
                      // if need impliment
                    }
                }
                .resizable()
                .placeholder(Image("man_placeholder"))
                .indicator(.activity)
                .frame(width: 30, height: 30)
                .cornerRadius(8)
                .clipped()
            
            
            VStack(alignment:.trailing) {
                
                messageView(message: message, bodyType: message.type)
                
                Text(message.getMessageTime())
                    .font(.customFont(.DMSansRegular, 12))
            }
            Spacer(minLength: 100)
        }//:HStack
        .padding(.horizontal,16)
    }
    
    
    func messageView(message:Message,bodyType:MessageTypes) -> AnyView?{
        
        switch bodyType {
            
        case .text:
            return AnyView(TextMessageView(message: message,isSender: false))
        case .image:
            return AnyView(ImageMessageView(message: message,isSender: false))
        case .pdf:
            return AnyView(PDFMessageView(message:message,isSender: false))
        case .location:
            return AnyView(LocationMessageView(message:message,isSender: false))

            
        }
        
    }
}

struct ReceiveTextMessageCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            chatBackgroundColor
            ReceiveMessageCellView(message: dumyMessage)
        }
    }
}






