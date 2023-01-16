//
//  MessageInput.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-25.
//

import SwiftUI

struct MessageInput: View {

    @Binding var textMessage:String
    var attachmentTapCallBack:()->()
    var sendTapCallBack:() async -> Void
    
    
    var body: some View {
        HStack {
         HStack {
                TextField("Type here ..", text:$textMessage)
                    .font(.customFont(.DMSansRegular, 14))
                    .padding(.vertical,10)
                    .padding(.horizontal, 10)
                
                
             Button {
                 attachmentTapCallBack()
             } label: {
                 Image("icon")
                     .resizable()
                     .frame(width:22,height: 22)
                     .padding(.horizontal, 8)
             }

              
                
            }//:HStack
            .overlay(
                
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 1)
                    .foregroundColor(grayColor)
                
            )
            
            
            
            AsyncButton(action: {
               await sendTapCallBack()
        
                       }, label: {
                           Image("ic_nav_foward")
                               .foregroundColor(whiteColor)
                               .padding(6)
                               .background(
                                   
                                   RoundedRectangle(cornerRadius: 5)
                                       .fill(themeColor)
                               )
                       })
            
         //   .disabled(textMessage.count == 0)
           
        

            
          
            
        }//:HStack
        .padding()
        .cornerRadius(8)
        .padding(.horizontal, 8)
        .background(backgroundColor)
    }
}

struct MessageInput_Previews: PreviewProvider {
    static var previews: some View {
        MessageInput(textMessage: .constant(""), attachmentTapCallBack: {}, sendTapCallBack:{ })
            .previewLayout(.sizeThatFits)
    }
}


struct AsyncButton<Label: View>: View {
    var action: () async -> Void
    @ViewBuilder var label: () -> Label

    @State private var isPerformingTask = false

    var body: some View {
        Button(
            action: {
                isPerformingTask = true
            
                Task {
                    await action()
                    isPerformingTask = false
                }
            },
            label: {
                ZStack {
                    // We hide the label by setting its opacity
                    // to zero, since we don't want the button's
                    // size to change while its task is performed:
                    label().opacity(isPerformingTask ? 0 : 1)

                    if isPerformingTask {
                        ProgressView()
                    }
                }
            }
        )
        .disabled(isPerformingTask)
    }
}
