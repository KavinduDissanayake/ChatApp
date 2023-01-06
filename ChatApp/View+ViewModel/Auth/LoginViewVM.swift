//
//  LoginVIewVM.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-06.
//

import Foundation

class LoginViewVM:BaseVM {
    
    @Published var emailText = ""
    @Published var passwordText = ""
    
    
    @Published var passwordValidation = false
    @Published var emailValidation = false
}

extension LoginViewVM {
    //MARK: - VALIDATION
    func proceedWithSignIn() -> Bool {
        if emailText.isEmpty {
            emailValidation = true
            return false
        } else if !Validators().isValidEmailValidator(value: emailText).isSuccess {
            emailValidation = true
            return false
        } else if passwordText.isEmpty {
            passwordValidation = true
            return false
        }
        else if !Validators().isValidPasswordValidator(value: passwordText).isSuccess {
            passwordValidation = true
            return false
        }
        return true
    }
    
    
}
