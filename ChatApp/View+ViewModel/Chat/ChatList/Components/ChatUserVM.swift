//
//  ChatUserVM.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-16.
//

import Foundation

class ChatUserVM: BaseVM {
    @Published var userModel: User? = nil
    var currentUser: User? = nil
    
    override init() {
        super.init()
        currentUser = PersistenceController.shared.loadLoclUserType()
    }
}

extension ChatUserVM {
    
    func getPorfile(userID:String,completion: @escaping (_ status: Bool) -> ()){
        AFWrapper.sharedInstance.showProfileGet(userId: userID) { userModelResponse in
            self.userModel =  userModelResponse.payload
            completion(true)
        } failure: { error in
            self.alertTitle = "Failed"
            self.alertMessage = ""
            self.isShowAlert = true
            completion(false)
        }
    }
    
    
    func goToChatRoom(completion: @escaping (Error) -> Void) async{
        if let userModel = userModel {
            await FirestoreDatabaseManager.shared.goToChatRoom(senderId: "\(currentUser?.id ?? 0)", receiverId: "\(userModel.id ?? 0)") { error in
                completion(error)
            }
        }else {
            completion(NoDataSet("No Data Set"))
        }
       
    }
}

struct NoDataSet: Error {
    let message: String
    init(_ message: String) {
        self.message = message
    }
}
