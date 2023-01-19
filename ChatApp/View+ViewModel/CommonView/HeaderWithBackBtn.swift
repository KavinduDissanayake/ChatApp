//
//  HeaderWithBackBtn.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-19.
//

import SwiftUI

struct HeaderWithBackBtn: View {
    var title:String
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack {
            
            CustomButton(iconName: "ic_arrow_back",btnTapCallback: {
                self.presentationMode.wrappedValue.dismiss()
            })
            .frame(width: 24,height: 24)
            
            Spacer()
            
            Text(title)
                .font(.customFont(.RalewayBold, 17))
            
            Spacer()
            
            ZStack{
            }//:ZStack
            .frame(width: 24,height: 24)
           
            
        }//:HStack
        .padding(.top, Screen.sizeFromHeight(size: 39))
        .padding(.horizontal,16)
        .padding(.bottom,16)
        .background(backgroundColor)
    }
}

struct HeaderWithBackBtn_Previews: PreviewProvider {
    static var previews: some View {
        HeaderWithBackBtn(title: "Text")
    }
}
