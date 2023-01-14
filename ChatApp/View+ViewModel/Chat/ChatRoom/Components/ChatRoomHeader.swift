//
//  HeaderWithBackView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-25.
//

import SwiftUI

struct ChatRoomHeader: View {
    var title:String
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode> 
    
    var body: some View {
        HStack {
    
            CustomButton(iconName: "ic_arrow_back",btnTapCallback: {
                self.presentationMode.wrappedValue.dismiss()
            })
           .padding()
            
            Spacer()
            
            HStack(spacing: 2) {
                Text(title)
                    .font(.customFont(.RalewayBold, 17))
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(Color("#43a061"))
                    .padding(.leading,10)
            }//:HStack
            
            Spacer()
            
            ZStack{
                CustomButton(iconName: "ic_call",btnTapCallback: {
                   
                })
            }//:ZStack
            .padding()
            
            
        }
      //  .padding(.top,mainScreenHieght * 20/375)
        //.background(Color.red)
    }
    
    
}

struct HeaderWithBackView_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomHeader(title:"Sanduni")
            .previewLayout(.sizeThatFits)
    }
}
