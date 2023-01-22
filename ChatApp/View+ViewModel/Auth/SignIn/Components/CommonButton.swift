//
//  CommonButton.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-06.
//

import SwiftUI

struct CommonButton: View {
    //MARK: - PROPERITY
    var title:String
    var width:CGFloat
    var height:CGFloat
    var action: (() -> ())
    
    
    //MARK: - BODY
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(title)
                .font(.customFont(.DMSansBold, 14))
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 48)
                .background(themeColor)
                .cornerRadius(24)
            
        })
    }
}

struct CommonButton_Previews: PreviewProvider {
    static var previews: some View {
        
        CommonButton(title: "Generate PDF", width: 220, height: 48, action: {} )
            .previewLayout(.sizeThatFits)    }
}
