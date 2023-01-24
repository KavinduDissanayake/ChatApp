//
//  SignUpCheckboxField.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-22.
//

import SwiftUI

struct CheckBoxField: View {
    //MARK: - PROPERITY
    
    @Binding var isMarked: Bool /// Binding here!
 
    //MARK: - BODY
    var body: some View {
        
        HStack{
            Button(action: {
                self.isMarked.toggle()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5).stroke(themeColor).frame(width: 20, height: 20)
                    if isMarked {
                        Image("ic_check")
                            .resizable()
                            .foregroundColor(themeColor)
                            .frame(width: 20, height: 20)
                    }
                }
            }
        }//;HStack
    }
}

struct CheckboxField_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxField(isMarked: .constant(true))
    }
}
