//
//  MenuItem.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-25.
//

import SwiftUI

struct MenuItem: View {
    var title:String
    var body: some View {
        HStack {
            Text(title)
                .font(.customFont(.DMSansBold, 15))
            Spacer()
            Image("ic_nav_foward")
                .resizable()
                .foregroundColor(grayColor)
                .frame(width: 30,height: 30)
        }
        .padding(.horizontal,20)
        //.padding(.vertical,10)
    }
}

struct MenuItem_Previews: PreviewProvider {
    static var previews: some View {
        MenuItem(title: "Account")
            .previewLayout(.sizeThatFits)
    }
}
