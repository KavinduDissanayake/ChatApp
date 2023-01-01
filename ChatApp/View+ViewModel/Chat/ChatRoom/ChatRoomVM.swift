//
//  ChatRoomVM.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-25.
//
import FirebaseFirestore
import Foundation
import Combine
import SwiftDate


//struct Note: Codable {
//    var id: String = UUID().uuidString  // @DocumentID to fetch the identifier from Firestore
//    var title: String?
//}


public struct MessageSection: Codable,Identifiable {
    
    public var id = UUID()
    
//    public static func == (lhs: MessageSection, rhs: MessageSection) -> Bool {
//        lh
//    }
    

    var title: String?
    var createdAt: Int?
    var messages: [Message] = []

    var count: Int {
        return messages.count
    }

    init(_ title: String, createdAt: Int) {
        // Title
        self.title = title
        self.createdAt = createdAt
    }

    subscript (index: Int) -> Message {
        get {
            return messages[index]
        }
        set {
            messages[index] = newValue
        }
    }

    public func hash(into hasher: inout Hasher){
        hasher.combine(self.title)
    }
}






struct Message:Identifiable,Codable {
    var id: String = UUID().uuidString  // @DocumentID to fetch the identifier from Firestore
    var idFrom = ""
    var idTo = ""
    var message = ""
    var isSeen = false
    var type = ""
    var time = 0
 
    
    
    var dictionary:[String:Any]{
        return [
            "idFrom":idFrom,
            "idTo":idTo,
            "message":message,
            "isSeen":isSeen,
            "type":type,
            "time":FieldValue.serverTimestamp()
        ]
    }
    
    
    func getMessageTime() -> String{
        let time = DateInRegion(milliseconds: time ?? 0, region: .current).toFormat("hh:mm a")
        return time
    }
    
    
}


//


class ChatRoomVM: BaseVM {
    
    @Published var textFiled = ""
    
    var currentUser = dummyUse1
    var contactUser = dummyUser2
    var firestore = Firestore.firestore()
    
    
    @Published var messagesList: [Message] = []// Reference to our Mo
    
    
    @Published var chatDataSource =  ChatDataSource()

    
    var totalUnread = 0
    
    @Published  var sections: [MessageSection] = []
    var allMessages: [Message] = []
}

//show alert
extension ChatRoomVM {
    func showAlert(error:Error?){
        self.isShowAlert = true
        self.alertTitle = "Error"
        self.alertMessage = error?.localizedDescription ?? ""
    }
}

//load messages
extension ChatRoomVM {
    
    func fetchData() {
        firestore
            .collection("chatroom")
            .document(getCurrentConversationID())
            .collection("chats")
            .addSnapshotListener { (querySnapshot, error) in
               guard let documents = querySnapshot?.documents else {
                   print("No documents")
                   return
               }
              
              
               self.messagesList = documents.map { (queryDocumentSnapshot) -> Message in
                   let data = queryDocumentSnapshot.data()

                   let time = data["time"] as? Timestamp
                   let date = Date(timeIntervalSince1970: TimeInterval(time?.seconds ?? 0))
                   let idFrom = data["idFrom"] as? String
                   let type = data["type"] as? String
                   return Message(idFrom:idFrom ?? "",message: "Text",type:type ?? "", time: Int(date.toMillis()))
               }
                
                self.chatDataSource.addMessages(messages:self.messagesList)
           }
       }
}

//text message
extension ChatRoomVM {
    
    func getConversationID( senderId:String, receiverId :String)->String {
        return senderId < receiverId ?  "\(senderId)_\(receiverId)" : "\(receiverId)_\(senderId)"
    }
    
    func getCurrentConversationID()->String {
        return getConversationID(senderId: currentUser._id ?? "", receiverId:contactUser._id ?? "")
    }
    
    func sendMessage(completion: @escaping CompletionBoolHandler) async{
        
        //conection check
        
        let message = Message(idFrom: currentUser._id ?? "", idTo: contactUser._id ?? "",message: textFiled, isSeen: false, type: "text")
   
        firestore
            .collection("chatroom")
            .document(getCurrentConversationID())
            .collection("chats")
            .addDocument(data:message.dictionary) { error in
                if error != nil {
                    self.showAlert(error: error)
                    completion(false)
                }else{
                    
                    //cleam text
                   // self.textFiled = ""
                 
                    
                    completion(true)
                }
            }
        
        await  updateMessage()
    }
    
    
    
    
}


//image message
extension ChatRoomVM {
    
    
}


//update message from user list messages
extension ChatRoomVM {
    
    func updateMessage() async{
        
        let userDb = firestore.collection("users")
        let chartRoomDb = firestore.collection("chatroom")
         
        do {
            
            let  checkChatsFriend = try await userDb.document(currentUser._id ?? "").collection("chats")
                .document(getCurrentConversationID())
                .getDocument()
            
            if checkChatsFriend.exists {
                
                
                let  checkTotalUnread = try await chartRoomDb.document(getCurrentConversationID())
                    .collection("chats")
                    .whereField("isSeen", isEqualTo: false)
                    .whereField("idTo", isEqualTo: currentUser._id ?? "")
                    .getDocuments()
                
                // total unread for friend
                totalUnread = checkTotalUnread.documents.count;
                
                DispatchQueue.main.async {
                    
                    userDb
                        .document(self.contactUser._id ?? "") //Contact ID
                        .collection("chats")
                        .document(self.getCurrentConversationID())
                        .updateData([
                            "lastMessage": self.textFiled,
                            "lastTime":"",
                            "total_unread":self.totalUnread,
                            "connectionName":self.currentUser.firstName ?? "",
                            
                        ]) { error in
                            
                        }
                }
                          
                
            }else {
                DispatchQueue.main.async {
                    
                    userDb
                        .document(self.contactUser._id ?? "") //Contact ID
                        .collection("chats")
                        .document(self.getCurrentConversationID())
                        .setData([
                            "lastMessage": self.textFiled,
                            "lastTime":"",
                            "total_unread":self.totalUnread,
                            "connectionName":self.currentUser.firstName ?? "",
                            
                        ]){ error in
                            
                            
                        }
                    
                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
        
        
        
    }
}


extension ChatRoomVM {
 

//    public func addMessage(message:Message){
//
//        let title = DateInRegion(milliseconds: message.time ?? 0, region: .current).toFormat("dd MMM, YYYY")
//
//
//        if !allMessages.contains(where: { $0.id == message.id} ) {
//            if let firstIndex = sections.firstIndex(where: {$0.title == title}) {
//                sections[firstIndex].messages.append(message)
//                allMessages.append(message)
//            }else{
//                //found new date groupe
//                //add new section
//                var newSection = MessageSection(title, createdAt: message.time ?? 0)
//                    newSection.messages.append(message)
//                    allMessages.append(message)
//                    sections.append(newSection)
//            }
//        }
//
//    }
//
//    public func addMessages(messages:[Message]){
//        sections = []
//        for message in messages {
//                addMessage(message: message)
//        }
//
//        sections.sort(by: {$0.createdAt ?? 0 < $1.createdAt ?? 0})
//        for index in 0..<sections.count{
//            sections[index].messages.sort(by: { $0.time ?? 0 < $1.time ?? 0 })
//        }
//    }



}


extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
