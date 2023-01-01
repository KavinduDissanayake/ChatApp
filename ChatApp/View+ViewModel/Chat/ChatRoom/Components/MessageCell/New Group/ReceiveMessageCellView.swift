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
            
            WebImage(url: URL(string: vm.contactUser.avatarUrl ?? ""))
                .onSuccess { image, data, cacheType in
                    DispatchQueue.main.async {
                      // if need impliment
                    }
                }
                .resizable()
                .placeholder(Image("man_placeholder"))
                .indicator(.activity)
                .frame(width: 40, height: 40)
                .cornerRadius(8)
                .clipped()
            
            
            VStack(alignment:.trailing) {
                
                messageView(message: message, bodyType:MessageType(rawValue: message.type) ?? .unknown)
                
                Text(message.getMessageTime())
                    .font(.customFont(.DMSansRegular, 12))
            }
            Spacer(minLength: 100)
        }//:HStack
        .padding(.horizontal,16)
    }
    
    
    func messageView(message:Message,bodyType:MessageType) -> AnyView?{
        
        switch bodyType {
            
        case .text:
            return AnyView(TextMessageView(message: message))
            
        case .image:
            return AnyView(TextMessageView(message: message))
            
            
        case .unknown:
            return AnyView(
                Text("unreadable message")
                    .font(.customFont(.DMSansRegular, 14))
                    .padding(12)
                //  .background(themeColor)
            )
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


public enum MessageType: String {
    
        case text = "text"
        case image = "image"
        case unknown
    }



 //   import SwiftUI

    struct TextMessageView: View {
        var message:Message
        var body: some View {
            Text(message.message)
                .font(.customFont(.DMSansRegular, 14))
                .padding(12)
                .background(themeColor)
                .foregroundColor(whiteColor)
                .cornerRadius(5, corners: .allCorners)
        }
        
        
    }

//    struct TextMessageView_Previews: PreviewProvider {
//        static var previews: some View {
//            TextMessageView(message:sampleMessage)
//                .previewLayout(.sizeThatFits)
//        }
//    }

