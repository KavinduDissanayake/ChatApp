//
//  PDFMessageView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-06.
//

import SwiftUI

struct PDFMessageView: View {
    var message:Message
    var isSender = true
    var body: some View {
       
        ZStack{
            VStack {
                Image("ic_pdf_view")
                    .resizable()
                    .frame(width:50,height:50)
               
            }
            HStack{
                Spacer()
                
                Image("ic_dowload")
                    .resizable()
                    .frame(width: 18,height: 18)
                    .foregroundColor(Color.black)
                    .padding(3)
                    .background(Color.white)
                    .cornerRadius(5)
                
            }
            .padding(.bottom,8)
            .padding(.trailing,5)
            .padding(.top,40)
            
        }//:VStack
        .background(Color("#e2574c").opacity(0.3))
        .frame(width:70,height: 80)
        .cornerRadius(12)
    }
}

struct PDFMessageView_Previews: PreviewProvider {
    static var previews: some View {
        PDFMessageView(message:dumyMessage)
    }
}
