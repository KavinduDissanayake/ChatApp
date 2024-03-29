//
//  ChatListVM.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-16.
//

import Foundation

class ChatListVM:BaseVM {
    
    override init() {
        super.init()
        currentUser = PersistenceController.shared.loadLoclUserType()
    }
    
    var currentUser: User? = nil
    @Published  var chatUserList: [ChatUser] = []
    @Published var searchText:String = ""
    var contactUserId:String = ""
    @Published var selectedUserModel: User? = nil
}

//load messages
extension ChatListVM {
    func fetchData(completion: @escaping CompletionBoolHandler) {
        FirestoreDatabaseManager.shared.getAllMessagesForConversation(q:searchText.isEmpty ? nil : searchText  , currentUserId: "\(currentUser?.id ?? 0)") { result in
            switch result {
            case .success(let chatUserList):
                self.chatUserList = chatUserList
                self.objectWillChange.send()
                completion(true)
            case .failure(let error):
                self.showAlert(error:error)
                completion(false)
            }
        }
    }
}
