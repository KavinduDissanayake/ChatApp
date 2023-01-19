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
    
    @State var showViwer : Bool = false
    
    
    var body: some View {
       
        ZStack {
            VStack{
                WebImage(url: URL(string: message.media?.sourceURL ?? "" ))
                    .placeholder(Image("Icon_placeholder"))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 160)
                    .frame(height: 110)
                    .cornerRadius(8)

            }//:VStack
            .padding(5)
            .background(isSender ? cardColor :themeColor)
            .foregroundColor(isSender ? nil : whiteColor)
            .cornerRadius(12)
            .frame(width: 180)
            .frame(height: 130)
            .onTapGesture {
                showViwer.toggle()
            }
            
            Text("")
                .sheet(isPresented: $showViwer) {
            
                            
                        VStack {
                            HeaderWithCloseView {
                                showViwer.toggle()
                            }
                        
                            Spacer()
                        }//:VStack
                        .background(
                            
                            WebImage(url: URL(string: message.media?.sourceURL ?? "" ))
                                .placeholder(Image("Icon_placeholder"))
                                .resizable()
                                .frame(width: mainScreenWidth)
                                .frame(height: mainScreenHieght)
                                .pinchToZoom()
                        
                        )
                  
            }
            
        }
    
    }
}


struct ImageMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageMessageView(message:dumyMessage,isSender: false)
    }
}


struct HeaderWithCloseView: View {
    var callBack:()->()
    
    var body: some View {
        
        HStack {
            
            CustomButton(iconName: "ic_close",btnTapCallback: {
                callBack()
            },iconFillColor:whiteColor,size: 18)
            .padding(.all,4)
            .background(themeColor)
            .cornerRadius(5)
            .padding(.leading,10)
            .padding(.top,10)
          
            Spacer()
            
        }//:HStack
    }
    
}
