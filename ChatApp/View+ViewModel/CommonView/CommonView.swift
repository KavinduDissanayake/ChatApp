//
//  CommonView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-19.
//

import SwiftUI

struct CommonView: View {
    var screenTitle:String
    var body: some View {
        
        ZStack {
            chatBackgroundColor
            
            VStack{
                
                HeaderWithBackBtn(title: screenTitle)
                
                GeometryReader { geometry in
                    
                    ScrollView(.vertical , showsIndicators: false) {
                        VStack(alignment: .center, spacing: 20) {
                            
                            Text(screenTitle)
                            
                            
                        }//:VStack
                        .frame(minHeight: geometry.size.height)
                    }//:ScrollView
                    .frame(width: geometry.size.width)
                }//:GeometryReader
            }//:VStack
            
        }//:ZStack
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}
struct CommonView_Previews: PreviewProvider {
    static var previews: some View {
        CommonView(screenTitle: "Text")
    }
}
