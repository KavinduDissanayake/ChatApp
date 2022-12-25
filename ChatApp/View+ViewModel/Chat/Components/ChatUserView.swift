//
//  ChatUserView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-24.
//

import SwiftUI

struct ChatUserView: View {
    
    var image: String = "user"
    var name: String = "John Doe"
    var time: String = "2:13PM"
    var bodyText: String = "Lorem ipsum dolor sit amet…"
    var isNew: Bool = true
    var btnCallBack: (() -> ())
    
    
    var body: some View {
        ZStack {
            
         //   Color.black
            
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(themeColor, lineWidth: 0.5)
                .background(
                    Group {
                        if isNew {
                              cardColor
                                .cornerRadius(10)
                        } else {
                            LinearGradient(
                                colors: [Color("#232325"), Color("#191919")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .cornerRadius(10)
                        }
                    }
                )
            
            HStack(alignment: .center, spacing: 0) {
                Image(image)
                    .resizable()
                    .frame(width: 70, height: 70, alignment: .center)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("#E3E3E3"), lineWidth: 2)
                    )
                    .padding(.trailing, 16)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center, spacing: 0) {
                        Text(name)
                            .font(.customFont(.DMSansBold, 14))
                            //.foregroundColor(Color.white)
                        
                        
                        Spacer()
                        
                        Text(time)
                            .font(.customFont(.DMSansRegular, 14))
                           // .foregroundColor(isNew ? Color.white : Color("#848484"))
                    }
                    .padding(.bottom, 20)
                    
                    .padding(.bottom, 20)
                    
                    HStack(alignment: .center, spacing: 0) {
                        Text(bodyText)
                            .lineLimit(1)
                            .font(.customFont(.DMSansMedium, 14))
                           // .foregroundColor(isNew ? Color.white : Color("#848484"))
                        
                        Spacer(minLength: 24)
                        
                        Group {
                            if isNew {
                                Image("dot_icon")
                                    .resizable()
                                    .foregroundColor(themeColor)
                            }
                        }
                        .frame(width: 10, height: 10)
                    }
                }
            }
            .padding(.all, 12)
            //.background(Color.red)
        }
       // .frame(maxWidth: .infinity)
        .frame(height:96)
        .padding(.leading,16)
        .padding(.trailing,16)
        .onTapGesture {
            
            btnCallBack()
        }
    }
}

struct ChatUserView_Previews: PreviewProvider {
    static var previews: some View {
        ChatUserView(){
            
        }
        .previewLayout(.sizeThatFits)
    }
}
