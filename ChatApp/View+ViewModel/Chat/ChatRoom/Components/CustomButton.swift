//
//  CustomButton.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-25.
//

import SwiftUI

struct CustomButton: View {
    var iconName:String
    var btnTapCallback:()->()
//    var fillColor:Color = cardColor
//    var shadowColor:Color = grayColor
    var iconFillColor:Color = grayColor
    
    var size:Double = 24
    
    var body: some View {
        
        Button(action: {
            btnTapCallback()
        }, label: {
            
         //   ZStack {
             
//                RoundedRectangle(cornerRadius: 5)
//                    .fill(fillColor)                // << here fill, not
//                       .frame(width: size, height: size, alignment: .center)
//                       .shadow(color: shadowColor, radius: 2, x: 0, y: 2)
//
                Image(iconName)
                    .resizable()
                    .frame(width: size - 2 ,height: size - 2 )
                    .foregroundColor(iconFillColor)

                    
       //     }//:ZStack
         
        })
        .frame(width: size)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(iconName: "ic_arrow_back",btnTapCallback: {})
            .previewLayout(.sizeThatFits)
    }
}
