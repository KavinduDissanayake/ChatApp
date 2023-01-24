//
//  Validators.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-06.
//

import Foundation
import SwiftUI


struct Validate: ViewModifier {
    
    var text: String
    var text2: String?
    var validation : (String, String?) -> ValidationStatus
    
    @State var active = false
    @State var latestValidation: ValidationStatus = .standard
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content
                .onTapGesture {
                    active = true
                }

            Group{
                if active {
                    switch validation(text, text2) {
                    case .success:
                         AnyView(EmptyView())
                    case .failure(let message):
                        let text = Text(message)
                            .font(.customFont(.DMSansMedium, 12))
                            .foregroundColor(redColor)
                         AnyView(text)
                    case .standard:
                        AnyView(EmptyView())
                    }
                }
            }
        }
      //  .background(Color.purple)
    }
}



extension View {
    func validate(with text: String,  text2: String? = nil, validation: @escaping (String, String?) ->  ValidationStatus ) -> some View {
        self.modifier(Validate(text: text, text2: text2, validation: validation))
    }
}

enum ValidationStatus {
    case standard
    case success
    case failure(message: String)
    
    var isSuccess: Bool {
        if case .success = self {
            return true
        }
        return false
    }
}





class Validators {
    
    func nonEmptyValidator(value : String, value2 : String? = nil)-> ValidationStatus {
        if(value.count > 0){
           return .success
        }
        
        return .failure(message: "Cannot be empty")
    }
    
    
    func isValidPasswordValidator(value : String, value2 : String? = nil)-> ValidationStatus {
        if(value.count > 7){
           return .success
        }
        
        return .failure(message: "Must be 8 characters or more")
    }
    
    
    func confirmPasswordValidator(value : String, value2 : String?)-> ValidationStatus {
        if(value.count < 7){
            return .failure(message: "Must be 8 digit or more")
        }
        if(value != value2){
            return .failure(message: "Password mismatch")
        }
        return .success
    }


    func matcherValidator(value : String, value2 : String) -> ValidationStatus {
//        let regex : Regex  = value2.r!
//
//        guard regex.matches(value) else {
//                return .failure(message: "")
//            }
        return .success
    }
    
    func isValidEmailValidator(value : String, value2 : String? = nil) -> ValidationStatus {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let regex : Regex  = pattern.r!
//
//        guard regex.matches(value) else {
//                return .failure(message: "Invalid email address")
//            }
         
        if !validate(input: value, pattern: pattern) {
            return .failure(message: "Invalid email address")
        }
        
        
        return .success
    }
    
    
    func isValidCharacterValidator(value : String, value2 : String? = nil) -> ValidationStatus {
        let pattern = "^(?=\\S{1})[a-zA-Z]\\w*(?:\\.\\w+)*(?:@\\w+\\.\\w{2,4})?$"

//        let regex : Regex  = pattern.r!
//
        
//        guard regex.matches(value) else {
//                return .failure(message: "Please use valid character")
//            }
        return .success
    }
    
    
    func isValidMaxCharacterValidator(value : String, value2 : String? = nil) -> ValidationStatus {
        
        let pattern = "^.{0,200}$"
//
//        let regex : Regex  = pattern.r!
//
//        guard regex.matches(value) else {
//                return .failure(message: "Please use less than 200 character")
//            }
        return .success
    }
    
    
    
    
    func validate(input: String,pattern: String) -> Bool {
        
           let range = NSRange(location: 0, length: input.utf16.count)
           let regex = try! NSRegularExpression(pattern:pattern)
           return regex.firstMatch(in: input, options: [], range: range) != nil
       }
    //MARK: - NOTE
    //https://stackoverflow.com/questions/44153773/username-regex-swift
}
