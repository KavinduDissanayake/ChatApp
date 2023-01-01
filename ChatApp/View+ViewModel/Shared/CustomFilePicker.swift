//
//  CustomFilePicker.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-31.
//
import UniformTypeIdentifiers
import SwiftUI

struct CustomFilePicker: View {
    
    @Binding var isImporting: Bool

    @Binding  var activeUIType:UTType
    
    var calbackPicked: (_ result: Result<URL, Error>) -> Void
        
    var body: some View {
        Text("")
            .fileImporter(isPresented: $isImporting, allowedContentTypes: [activeUIType]) { result in
                calbackPicked(result)
            }
           
        
    }
}

struct CustomFilePicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomFilePicker(isImporting: .constant(false), activeUIType:.constant(.image)){
            result in
            
        }
    }
}
