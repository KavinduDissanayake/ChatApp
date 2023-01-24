//
//  AuthHeader.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-22.
//

import SwiftUI

struct AuthHeader: View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        HStack {
            CustomButton(iconName: "ic_arrow_back",btnTapCallback: {
                self.presentationMode.wrappedValue.dismiss()

            })
            Spacer()
            Image("Icon_placeholder")
                .resizable()
                .frame(width: 40,height: 40)
            Spacer()
            HStack{}
                .frame(width: 22,height: 22)
        }
        .padding(.top,mainScreenHieght * 20/375)
        .padding(.horizontal,16)
     
    }
}

struct AuthHeader_Previews: PreviewProvider {
    static var previews: some View {
        AuthHeader()
    }
}
