//
//  ContactListVM.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-15.
//

import Foundation


class ContacVM:BaseVM {
    
    //MARK: - PROPERITY
    @Published var searchText:String = ""
    @Published var contactList:[User] = []
    
    var currentPage =  0
    var lastPage =  0
}

extension ContacVM {
    
    
    //MARK: - getProfileRequest FUNCATION
    func getProfileListRequest(page: Int, perPage: Int, isPaging: Bool? = false,completion: @escaping (_ status: Bool) -> ()) {
        
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            self.alertTitle = "Failed"
            self.alertMessage = "Internet connection appears to be offline."
            self.isShowAlert = true
            completion(false)
            return
        }
        
        AFWrapper.sharedInstance.getUserListGet(q: searchText.isEmpty ? nil : searchText, perPage: perPage, page: page, exceptoRles: nil) { userResponse in
            
            self.currentPage = userResponse.payload?.currentPage ?? 0
            self.lastPage = userResponse.payload?.lastPage ?? 0
            
            if isPaging ?? false{
                self.contactList += userResponse.payload?.data ?? []
            }else{
                self.contactList = userResponse.payload?.data ?? []

            }
            
            completion(true)
            return
        } failure: { error in
            
            self.alertTitle = "Failed"
            self.alertMessage = error.localizedDescription
            self.isShowAlert = true
            print("🩸\(error.localizedDescription)")
            completion(false)
        }
        
    }
    
}
