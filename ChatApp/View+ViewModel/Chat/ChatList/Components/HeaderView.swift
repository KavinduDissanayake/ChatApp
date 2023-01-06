//
//  HeaderView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-24.
//

import SwiftUI

struct HeaderView: View {
    var title:String
    var body: some View {
        
        HStack{
            Spacer()
            Text(title)
                .font(.customFont(.RalewayBold, 17))
            Spacer()
            
        }
        .padding(.top,mainScreenHieght * 20/375)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Message")
            .previewLayout(.sizeThatFits)
    }
}
