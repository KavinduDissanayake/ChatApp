//
//  ProfileVM.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-15.
//

import Foundation


class ProfileVM:BaseVM {
    @Published var user:User?
    
}

extension ProfileVM {
    

    //MARK: - LOGIN FUNCATION
    func getProfileRequest(completion: @escaping (_ status: Bool) -> ()) {
        
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            self.alertTitle = "Failed"
            self.alertMessage = "Internet connection appears to be offline."
            self.isShowAlert = true
            completion(false)
            return
        }
        
        AFWrapper.sharedInstance.userProfileGet { userResponse in
            guard let userModel = userResponse.payload else { return }
            self.user = userModel
            completion(true)
            return
        } failure: { error in
            self.alertTitle = "Failed"
            self.alertMessage = error.localizedDescription
            self.isShowAlert = true
            completion(false)
        }
        
    }
    
    func calculateAge(fromDOB dobString: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let dob = dateFormatter.date(from: dobString) else { return 0 }
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: dob, to: Date())
        return ageComponents.year ?? 0
    }
    
}
