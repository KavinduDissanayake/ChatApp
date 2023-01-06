//
//  ImagePickerView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-01.
//

import SwiftUI

struct ImagePickerView: View {
    
    @Binding var showSheet:Bool
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    var didImagePicked:((UIImage,URL)->Void)
    
    
    var body: some View {
        Text("")
            .sheet(isPresented: $showSheet) {
                ImagePicker(sourceType: sourceType){ (image,url) in
                    didImagePicked(image,url)
                }
            }
    }
}
    
    struct ImagePickerView_Previews: PreviewProvider {
        static var previews: some View {
            ImagePickerView(showSheet:.constant(false)){ (image,url) in
            }
        }
    }
    
    
    struct ImagePicker: UIViewControllerRepresentable {
        @Environment(\.presentationMode) private var presentationMode
        var sourceType: UIImagePickerController.SourceType = .photoLibrary
        var didImagePicked:((UIImage,URL)->Void)?
        
        
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
            
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = false
            imagePicker.sourceType = sourceType
            imagePicker.delegate = context.coordinator
            
            return imagePicker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
            
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            
            var parent: ImagePicker
            
            init(_ parent: ImagePicker) {
                self.parent = parent
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                
                guard let _selectedImg = info[.originalImage] as? UIImage else { return }
                guard let imageURL = info[.imageURL] as? URL else { return } // need to save edited image and get url of it
                self.parent.didImagePicked?(_selectedImg,imageURL)
                parent.presentationMode.wrappedValue.dismiss()
            }
            
        }
    }

