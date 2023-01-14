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

extension LoginViewVM {
    

    //MARK: - LOGIN FUNCATION
    func loginRequest(completion: @escaping (_ status: Bool) -> ()) {
        
        if !proceedWithSignIn() {
            completion(false)
            return
        }

        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            self.alertTitle = "Failed"
            self.alertMessage = "Internet connection appears to be offline."
            self.isShowAlert = true
            completion(false)
            return
        }
        
        AFWrapper.sharedInstance.userLogin(email: emailText, password: passwordText) { userResponse in
           //save Local User
            guard let userModel = userResponse.payload else { return }
            PersistenceController.shared.saveUserData(with: userModel)
            completion(true)
            return
        } failure: { error in
            self.alertTitle = "Failed"
            self.alertMessage = error.localizedDescription
            self.isShowAlert = true
            completion(false)
        }
        
    }
    
    
}
