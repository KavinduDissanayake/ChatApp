//
//  SettingsView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-19.
//

import SwiftUI

struct SettingsView: View {
    
    
    @AppStorage("isDarkMode") private var isDarkMode = false

    
    
    
    var body: some View {
        
        ZStack {
            chatBackgroundColor
            
            VStack{
                
                HeaderWithBackBtn(title: "Settings")
                
                GeometryReader { geometry in
                    
                    ScrollView(.vertical , showsIndicators: false) {
                        VStack(alignment: .center, spacing: 20) {
                            
                            VStack{
                                
                                Toggle(isOn: $isDarkMode, label: {
                                           Text("Dark Mode")
                                        .font(.customFont(.DMSansMedium, 14))
                                       })
                                .padding(.all,8)
                                
                            }//:VStack
                            .background(backgroundColor)
                            .cornerRadius(10)
                            .padding()
                            
                            
                            Spacer()
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
