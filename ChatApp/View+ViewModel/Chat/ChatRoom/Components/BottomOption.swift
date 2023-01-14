//
//  BottomOpetions.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-01.
//

import SwiftUI
import UniformTypeIdentifiers

struct BottomoOption: View {
    

    var pdfTapCallback:()->()
    var imageTapCallback:()->()
    var cancelTapCallback:()->()
    
    var body: some View {
        ZStack {
           
            VStack(alignment:.leading,spacing: 0){
                Text("Select your message Type ")
                    .font(.customFont(.RalewayBold, 15))
                    .padding(.leading,16)
                    .padding(.top,16)
                
                Text("In here you can selecet this type of meessges ")
                    .font(.customFont(.RalewaySemiBold, 13))
                    .padding(.leading,16)
                    .padding(.top,5)
                    .padding(.bottom,16)
       
                ButtonOutLineWithImage(imageName: "ic_pdf",title:"Select your PDF file") {
                    pdfTapCallback()
                   
                }
                
                ButtonOutLineWithImage(imageName: "ic_image",title:"Select your image file") {
                   
                    imageTapCallback()
                   
                }
                
                
                LargeButton(title: "Cancel",
                            backgroundColor: redColor) {
                    cancelTapCallback()
                                    }
                            .padding(.top,15)

          
            }//:VStack
           
        }//:ZStack
    }
}

struct BottomOpetions_Previews: PreviewProvider {
    static var previews: some View {
        BottomoOption(pdfTapCallback: {}, imageTapCallback: {}, cancelTapCallback: {})
    }
}
