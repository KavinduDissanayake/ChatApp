//
//  DatabaseManager.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-03.
//

import Foundation
import FirebaseFirestore

/// Manager object to read and write data to real time firebase database
final class FirestoreDatabaseManager {
    
    /// Shared instance of class
    public static let shared = FirestoreDatabaseManager()
    
    private let database = Firestore.firestore()
    
    func getConversationID( senderId:String, receiverId :String)->String {
        return senderId < receiverId ?  "\(senderId)_\(receiverId)" : "\(receiverId)_\(senderId)"
    }
    
    var totalUnread = 0
    
    var chatDataSource =  ChatDataSource()
    
}

extension FirestoreDatabaseManager {
    
    
    public func goToChatRoom(senderId:String,receiverId :String,completion: @escaping (Error) -> Void) async {
        
        do {
            let updateStatusChat = try  await database.collection("chatroom")
                .document(getConversationID(senderId: senderId, receiverId: receiverId))
                .collection("chats")
                .whereField("isSeen", isEqualTo: false)
                .whereField("idTo", isEqualTo: senderId)
                .getDocuments()
            
            updateStatusChat.documents.forEach { (element) in
                print(element.documentID)
                
                database.collection("chatroom")
                    .document(getConversationID(senderId: senderId, receiverId: receiverId))
                    .collection("chats").document(element.documentID)
                    .updateData(["isSeen": true]) { (error) in
                        if let error = error {
                            print("Update failed: \(error)")
                            completion(error)
                        } else {
                            print("Updated")
                        }
                    }
                
                
            }
            DispatchQueue.main.async {
                self.database.collection("users").document(senderId).collection("chats")
                    .document(self.getConversationID(senderId: senderId, receiverId: receiverId))
                    .updateData(["total_unread": 0]) { (error) in
                        if let error = error {
                            print("Update failed: \(error)")
                            completion(error)
                        } else {
                            print("Updated")
                        }
                    }
            }
            
        } catch let error {
            print("Update failed: \(error)")
        }
        
    }
    
    ///Get all chat list
    public func getAllMessagesForConversation(q:String? = nil ,currentUserId:String, completion: @escaping (Result<[ChatUser], Error>) -> Void){
        let userDb = database.collection("users")
        
        if !(q ?? "").isEmpty {
            userDb
                .document(currentUserId)
                .collection("chats")
                .order(by: "lastTime", descending: true)
                .whereField("lastMessage", isEqualTo: q ?? "" )
                .addSnapshotListener { (snapshot, error) in
                    guard let documents = snapshot?.documents else {
                        print("No documents")
                        completion(.success([]))
                        return
                    }
                    
                    let chatUserList: [ChatUser]  =  documents.map { (queryDocumentSnapshot) -> ChatUser in
                        let data = queryDocumentSnapshot.data()
                        
                        let time = data["lastTime"] as? Timestamp
                        let date = Date(timeIntervalSince1970: TimeInterval(time?.seconds ?? 0))
                        let lastMessage = data["lastMessage"] as? String
                        let totalUnread = data["total_unread"] as? Int
                        let connectionName = data["connectionName"] as? String
                        let connection = data["connection"] as? String
                        
                        return ChatUser(connection: connection ?? "", connectionName:connectionName ?? "", lastMessage: lastMessage, lastTime: Int(date.toMillis()), totalUnread:totalUnread ?? 0)
                    }
                    
                    completion(.success(chatUserList))
                }
            
            
            
        }else {
            userDb
                .document(currentUserId)
                .collection("chats")
                .order(by: "lastTime", descending: true)
            //            .whereField("connectionName", isEqualTo: q )
                .addSnapshotListener { (snapshot, error) in
                    guard let documents = snapshot?.documents else {
                        print("No documents")
                        return
                    }
                    
                    let chatUserList: [ChatUser]  =  documents.map { (queryDocumentSnapshot) -> ChatUser in
                        let data = queryDocumentSnapshot.data()
                        
                        let time = data["lastTime"] as? Timestamp
                        let date = Date(timeIntervalSince1970: TimeInterval(time?.seconds ?? 0))
                        let lastMessage = data["lastMessage"] as? String
                        let totalUnread = data["total_unread"] as? Int
                        let connectionName = data["connectionName"] as? String
                        let connection = data["connection"] as? String
                        
                        return ChatUser(connection: connection ?? "", connectionName:connectionName ?? "", lastMessage: lastMessage, lastTime: Int(date.toMillis()), totalUnread:totalUnread ?? 0)
                    }
                    
                    completion(.success(chatUserList))
                }
        }
        
    }
    
}



// MARK: - Sending messages / conversations

//chat room
extension FirestoreDatabaseManager {
    
    
    
    
    /// Gets all mmessages for a given conversation
    public func getAllMessagesForConversation(senderId:String,receiverId :String, completion: @escaping (Result<ChatDataSource, Error>) -> Void) {
        
        let chatRoomDb = database.collection("chatroom")
        chatRoomDb
            .document(getConversationID(senderId: senderId, receiverId: receiverId))
            .collection("chats")
            .addSnapshotListener { (snapshot, error) in
                
                
                guard let documents = snapshot?.documents else {
                    print("No documents")
                    return
                }
                //
                let messagesList: [Message]  =  documents.map { (queryDocumentSnapshot) -> Message in
                    let data = queryDocumentSnapshot.data()
                    
                    let time = data["time"] as? Timestamp
                    let date = Date(timeIntervalSince1970: TimeInterval(time?.seconds ?? 0))
                    let idFrom = data["idFrom"] as? String
                    let type = data["type"] as? String
                    let message = data["message"] as? String
                    //       documents
                    let messageType = MessageTypes(rawValue: type ?? "")
                    
                    switch messageType {
                        
                    case .text:
                        return Message(idFrom:idFrom ?? "",message: message ?? "" ,type: messageType ?? .text, time: Int(date.toMillis()))
                        
                    case .image:
                        let media =  data["media"] as? [String:AnyObject]
                        let sourceUrl = media?["source_url"] as? String
                        let mediaModel = Media(sourceURL: sourceUrl ?? "")
                        return Message(idFrom:idFrom ?? "",message: message ?? "" ,type: messageType ?? .text, time: Int(date.toMillis()),media: mediaModel)
                    case .pdf:
                        let media =  data["media"] as? [String:AnyObject]
                        let sourceUrl = media?["source_url"] as? String
                        let mediaModel = Media(sourceURL: sourceUrl ?? "")
                        return Message(idFrom:idFrom ?? "",message: message ?? "" ,type: messageType ?? .text, time: Int(date.toMillis()),media: mediaModel)
                        
                    case .location:
                        let location =  data["location"] as? [String:AnyObject]
                        let lat = location?["latitude"] as? String
                        let lon = location?["longitude"] as? String
                        let locationModel = Location(locationName: "", latitude:lat ?? "", longitude: lon ?? "" )
                        
                        return Message(idFrom:idFrom ?? "",message: message ?? "" ,type: messageType ?? .text, time: Int(date.toMillis()),location: locationModel)
                        
                    case .none:
                        return Message(idFrom:idFrom ?? "",message: "Unwon",type: messageType ?? .text, time: Int(date.toMillis()))
                        
                    }
                    
                }
                
                self.chatDataSource.addMessages(messages:messagesList)
                
                
                completion(.success(self.chatDataSource))
            }
        
    }
    
    
    
    /// Creates a new conversation with target user emamil and first message sent
    public func createNewConversation(senderName:String,senderId:String,receiverName :String, receiverId :String, firstMessage: Message, completion: @escaping (Bool,Error?) -> Void) {
        
        let chatRoomDb = database.collection("chatroom")
        
        let _ = chatRoomDb
            .document(getConversationID(senderId: senderId, receiverId: receiverId))
            .collection("chats")
            .addDocument(data:firstMessage.dictionary)  { error in
                
                
                if error != nil {
                    completion(false,error)
                }
                
                //   completion(true)
                Task {
                    
                    await self.updateSenderUser(senderName: senderName, senderId: senderId,receiverName:receiverName, receiverId: receiverId, firstMessage: firstMessage, completion: { sucees, error in
                        completion(false,error)
                    })
                    
                }
                
                Task {
                    
                    await self.updateReceiverUser(senderName: senderName, senderId: senderId,receiverName:receiverName, receiverId: receiverId, firstMessage: firstMessage, completion: { sucees, error in
                        completion(false,error)
                    })
                    
                }
                
                completion(true,nil)
                
            }
        
        
        
    }
    
    
    
    public  func updateReceiverUser(senderName:String,senderId:String,receiverName :String, receiverId :String, firstMessage: Message, completion: @escaping (Bool,Error?) -> Void) async{
        
        
        let userDb = database.collection("users")
        let chatRoomDb = database.collection("chatroom")
        //update current user side ------------------------------
        
        
        do {
            let  checkChatsFriend =
            try await userDb
                .document(receiverId).collection("chats")
                .document(self.getConversationID(senderId: senderId, receiverId: receiverId))
                .getDocument()
            
            //check alrady has chat or not
            
            if checkChatsFriend.exists {
                
                let  checkTotalUnread =  try await
                chatRoomDb
                    .document(self.getConversationID(senderId: senderId, receiverId: receiverId))
                    .collection("chats")
                    .whereField("isSeen", isEqualTo: false)
                    .whereField("idTo", isEqualTo: receiverId)
                    .getDocuments()
                
                // total unread for friend
                totalUnread = checkTotalUnread.documents.count
                print("🛑 Total un read message documents count \(checkTotalUnread.documents.count)")
                
                
                print("🛑 Total un read message count \(totalUnread)")
                
                //update
                DispatchQueue.main.async {
                    userDb
                        .document(receiverId) //Contact ID
                        .collection("chats")
                        .document(self.getConversationID(senderId: senderId, receiverId: receiverId))
                        .updateData([
                            "lastMessage": firstMessage.message,
                            "lastTime":FieldValue.serverTimestamp(),
                            "total_unread":self.totalUnread,
                            "connection": senderId,
                            "connectionName":senderName,
                            
                        ]) { error in
                            
                            // print(error)
                            completion(false, error)
                        }
                }
                
                
            }else{
                DispatchQueue.main.async {
                    userDb
                        .document(receiverId) //Contact ID
                        .collection("chats")
                        .document(self.getConversationID(senderId: senderId, receiverId: receiverId))
                        .setData([
                            "lastMessage": firstMessage.message,
                            "lastTime":FieldValue.serverTimestamp(),
                            "total_unread":1,
                            "connection": senderId,
                            "connectionName":senderName,
                            
                        ]){ error in
                            
                            //print(error)
                            completion(false,error)
                        }
                }
            }
            
        }
        catch {
            print(error.localizedDescription)
            completion(false, error)
        }
        
    }
    
    
    public  func updateSenderUser(senderName:String,senderId:String,receiverName :String, receiverId :String, firstMessage: Message, completion: @escaping (Bool,Error?) -> Void) async{
        
        
        let userDb = database.collection("users")
        //  let chatRoomDb = database.collection("chatroom")
        //update current user side ------------------------------
        do {
            let  checkChatsFriend =
            try await userDb
                .document(senderId)
                .collection("chats")
                .document(self.getConversationID(senderId: senderId, receiverId: receiverId))
                .getDocument()
            
            //check alrady has chat or not
            
            if checkChatsFriend.exists {
                DispatchQueue.main.async {
                    userDb
                        .document(senderId) //Contact ID
                        .collection("chats")
                        .document(self.getConversationID(senderId: senderId, receiverId: receiverId))
                        .updateData([
                            "lastMessage": firstMessage.message,
                            "lastTime":FieldValue.serverTimestamp(),
                            // "total_unread":totalUnread,
                            "connection": receiverId,
                            "connectionName":receiverName,
                            
                        ]) { error in
                            // print(error)
                            completion(false, error)
                        }
                }
                
            }else{
                DispatchQueue.main.async {
                    userDb
                        .document(senderId) //Contact ID
                        .collection("chats")
                        .document(self.getConversationID(senderId: senderId, receiverId: receiverId))
                        .setData([
                            
                            "lastMessage": firstMessage.message,
                            "lastTime":FieldValue.serverTimestamp(),
                            "total_unread":0,
                            "connection": receiverId,
                            "connectionName":receiverName,
                            
                        ]){ error in
                            //print(error)
                            completion(false,error)
                        }
                }
                
            }
            
        }
        catch {
            print(error.localizedDescription)
            completion(false, error)
        }
        
    }
    
    
    
    public  func markAsReadMessages(senderId:String,receiverId :String, completion: @escaping (Bool,Error?) -> Void) async{
        
        let userDb = database.collection("users")
        let chatRoomDb = database.collection("chatroom")
        
        do {
            
            //quarry update current user
            let  updateStatusChat =
            try await chatRoomDb
                .document(self.getConversationID(senderId: senderId, receiverId: receiverId))
                .collection("chats")
                .whereField("isSeen", isEqualTo: false)
                .whereField("idTo", isEqualTo: senderId)
                .getDocuments()
            
            
            updateStatusChat.documents.forEach { element in
                print(element.documentID)
                
                
                
                Task{
                    
                    chatRoomDb
                        .document(self.getConversationID(senderId: senderId, receiverId: receiverId))
                        .collection("chats")
                        .document(element.documentID)
                        .updateData(["isSeen": true]) { error in
                            // print(error)
                            completion(false, error)
                        }
                }
            }
            
            
            //set the users show images count to 0
            Task{
                userDb
                    .document(senderId)
                    .collection("chats")
                    .document(self.getConversationID(senderId: senderId, receiverId: receiverId))
                    .updateData(["total_unread": 0]){ error in
                        // print(error)
                        completion(false, error)
                    }
            }
            
            
        } catch {
            print(error.localizedDescription)
            completion(false, error)
        }
    }
    
}


public enum DatabaseError: Error {
    case failedToFetch
    
    public var localizedDescription: String {
        switch self {
        case .failedToFetch:
            return "This means data fetch failed"
        }
    }
}
