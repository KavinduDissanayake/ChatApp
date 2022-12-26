//
//  SenderTextMessageCellView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-26.
//

import SwiftUI

struct SenderTextMessageCellView: View {
    var body: some View {
        HStack(alignment:.top) {
            Spacer(minLength: 100)

            VStack(alignment:.trailing) {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .font(.customFont(.DMSansRegular, 14))
                    .padding(12)
                    .background(cardColor)
                .cornerRadius(5, corners: .allCorners)
                
                Text("12:00 PM")
                    .font(.customFont(.DMSansRegular, 12))
            }
            
            
          
        }//:HStack
        .padding(.horizontal,16)
    }
}

struct SenderTextMessageCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            chatBackgroundColor
            SenderTextMessageCellView()
        }
    }
}
