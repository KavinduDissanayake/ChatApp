//
//  ChatRoomVM.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-25.
//
import FirebaseFirestore
import Foundation


//struct Note: Codable {
//    var id: String = UUID().uuidString  // @DocumentID to fetch the identifier from Firestore
//    var title: String?
//}

struct Message:Identifiable,Codable {
    
    var id: String = UUID().uuidString  // @DocumentID to fetch the identifier from Firestore
    var idFrom = ""
    var idTo = ""
    var message = ""
    var isSeen = false
    var type = ""
    var time = ""
    
    var dictionary:[String:Any]{
        return [
            "idFrom":idFrom,
            "idTo":idTo,
            "message":message,
            "isSeen":isSeen,
            "type":type,
            "time":time
        ]
    }
    
}

//updateUserMessageList(
//     {bool isFile = false, String fileType = "@Image"}) async {
//   CollectionReference users = firestore.collection("users");
//
//   final checkChatsFriend = await users
//       .doc(contactUserID.value) // passs contact id
//       .collection("chats")
//       .doc(getConversationID(currentUserID.value, contactUserID.value))
//       .get();
//
//   if (checkChatsFriend.exists) {
//     // exist on friend DB
//     // first check total unread
//     final checkTotalUnread = await firestore
//         .collection('chatroom')
//         .doc(getConversationID(currentUserID.value, contactUserID.value))
//         .collection('chats')
//         .where("isSeen", isEqualTo: false)
//         .where("idTo", isEqualTo: contactUserID.value)
//         .get();
//
//     // total unread for friend
//     totalUnread = checkTotalUnread.docs.length;
//
//     //update
//     await users
//         .doc(contactUserID.value) //Contact ID
//         .collection("chats")
//         .doc(getConversationID(currentUserID.value, contactUserID.value))
//         .update({
//           "lastMessage": isFile ? fileType : messageText.text,
//           "lastTime": DateTime.now().toUtc().toString(),
//           "total_unread": totalUnread,
//       "connectionName": SharedPrefs.getUserName() ?? "",
//         })
//         .then((_) => showDebugLogger(debug: 'Updated'))
//         .catchError(
//             (error) => showErrorLogger(error: 'Update failed: $error'));
//
//     messageText.clear();
//   } else {
//     await users
//         .doc(contactUserID.value)
//         .collection("chats")
//         .doc(getConversationID(currentUserID.value, contactUserID.value))
//         .set({
//           "connection": currentUserID.value,
//           "lastMessage": messageText.text,
//           "lastTime": DateTime.now().toUtc().toString(),
//           "total_unread": 1,
//          "connectionName": SharedPrefs.getUserName() ?? "",
//
//     })
//         .then((_) => showDebugLogger(debug: 'Updated'))
//         .catchError(
//             (error) => showErrorLogger(error: 'Update failed: $error'));
//
//     messageText.clear();
//     //Alert Trigger
//     showDebugLogger(debug: ('messageSuccess').tr);
//
//     // DialogHelper.shared
//     //     .successSnackBar(('messageTitle').tr, ('messageSuccess').tr);
//   }
// }

//Map<String, dynamic> messages = {
//       "idFrom": currentUserID.value,
//       "idTo": contactUserID.value,
//       "message": messageText.text,
//       "isSeen": false,
//       "type": "text",
//       "time": DateTime.now().toUtc().toString(),
//     };
//
//     await firestore
//         .collection('chatroom')
//         .doc(getConversationID(currentUserID.value, contactUserID.value))
//         .collection('chats')
//         .add(messages)
//         .then((doc) {
//       sendMessageMessageNotification(
//           messageText.text, "text", contactUserID.value);
//     }).catchError((onError) {
//       showErrorLogger(error: onError.toString());
//     });

class ChatRoomVM: BaseVM {
    
    @Published var textFiled = ""
    
    var currentUser = dummyUse1
    var contactUser = dummyUser2
    var firestore = Firestore.firestore()
    
    
    @Published var messagesList: [Message] = []// Reference to our Mo
    
    //    @Published var notes = [Note]() // Reference to our Model
    //    private var databaseReference = Firestore.firestore().collection("Notes") // reference to our Firestore's collection
    //    // function to post data
    //    func addData(title: String) {
    //        do {
    //            _ = try databaseReference.addDocument(data: ["title": title])
    //        }
    //        catch {
    //            print(error.localizedDescription)
    //        }
    //    }
    
    var totalUnread = 0
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
                   let surname = data["title"] as? String ?? ""
                   
                   
                   return Message(message: "Text")
               }
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
        
        let message = Message(idFrom: currentUser._id ?? "", idTo: contactUser._id ?? "",message: textFiled, isSeen: false, type: "text", time: "")
        
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
