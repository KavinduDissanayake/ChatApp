//
//  CommonAlert.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-26.
//


import SwiftUI

struct CommonAlert: View {
    //MARK: - PROPERITY
    @Binding var isShowAlert:Bool
    var alertTitle:String
    var alertMessage:String
    var action: (() -> ())?
    
    
    //MARK: - BODY
    var body: some View {
        Text("")
        //MARK: - ALERT
        .alert(isPresented: $isShowAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok"),action: {
                //isShowAlert.toggle()
                action?()
            }))
        }
    }
}

//MARK: - PREVIEW
struct CommonAlert_Previews: PreviewProvider {
    static var previews: some View {
        CommonAlert(isShowAlert: .constant(true), alertTitle: "Alert Titel", alertMessage:"Alert Message")
            .previewLayout(.sizeThatFits)
    }
}

