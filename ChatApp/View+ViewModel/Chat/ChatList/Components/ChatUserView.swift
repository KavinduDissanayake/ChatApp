//
//  ChatUserView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatUserView: View {
    var chatUser:ChatUser
    var btnCallBack: ((User?) -> ())
    
    //MARK: - PROPERITY
    @StateObject var vm = ChatUserVM()
    
    
    var body: some View {
        ZStack {
                    
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(themeColor, lineWidth: 0.5)
                .background(
                    Group {
                        if (chatUser.totalUnread ?? 0) > 0  {
                              cardColor
                                .cornerRadius(10)
                        } else {
                            LinearGradient(
                                colors: [Color("#232325"), Color("#191919")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .cornerRadius(10)
                        }
                    }
                )
            
            HStack(alignment: .center, spacing: 0) {
              
                WebImage(url: URL(string:vm.userModel?.avatarURL ?? ""))
                    .placeholder(Image("Icon_placeholder"))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60, alignment: .center)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("#E3E3E3"), lineWidth: 2)
                    )
                    .padding(.trailing, 16)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center, spacing: 0) {
                        Text(vm.userModel?.name ?? "")
                            .font(.customFont(.DMSansBold, 13))
                        
                        
                        Spacer()
                        
                        Text(chatUser.getMessageTime())
                            .font(.customFont(.DMSansRegular, 13))
                    }
                  
                    HStack(alignment: .center, spacing: 0) {
                        Text(chatUser.lastMessage ?? "N/A")
                            .lineLimit(3)
                            .font(.customFont(.DMSansRegular, 13))
                        
                       
                        Spacer()
                        
                        Group {
                            if (chatUser.totalUnread ?? 0) > 0  {
                                VStack {
                                    //Spacer()
                                    Text("\(chatUser.totalUnread ?? 0)")
                                        .font(.customFont(.DMSansRegular, 12))
                                        .frame(width: 14, height: 14, alignment: .center)
                                        .padding(4)
                                        .overlay(
                                            Circle()
                                                .fill(themeColor.opacity(0.2))
                                            .padding(2)
                                    )
                                }
                                   
                            }
                        }
                    }
                   .frame(height: 45)
                }
            }
            .padding(.all, 12)
            //.background(Color.red)
            
            Text("")
                .onAppear{
                    vm.getPorfile(userID: chatUser.connection ?? "") { suecss in
                    
                    }
                }
            
        }
        .frame(height:90)
        .padding(.leading,16)
        .padding(.trailing,16)
        .padding(.vertical,5)
        .onTapGesture {
           Task{
               await vm.goToChatRoom { error in
                    }
            }
            btnCallBack(vm.userModel)

        }
    }
}

//struct ChatUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatUserView(){
//
//        }
//        .previewLayout(.sizeThatFits)
//    }
//}
