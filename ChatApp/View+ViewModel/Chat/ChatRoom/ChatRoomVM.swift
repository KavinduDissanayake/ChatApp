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
    
}

//show alert
extension ChatRoomVM {
    func showAlert(error:Error?){
        self.isShowAlert = true
        self.alertTitle = "Error"
        self.alertMessage = error?.localizedDescription ?? ""
    }
}


//text message
extension ChatRoomVM {
    
    func getConversationID( senderId:String, receiverId :String)->String {
        return senderId < receiverId ?  "\(senderId)_\(receiverId)" : "\(receiverId)_\(senderId)"
    }
        
    func sendMessage(completion: @escaping CompletionBoolHandler){
        
        let message = Message(idFrom: currentUser._id ?? "", idTo: contactUser._id ?? "",message: textFiled, isSeen: false, type: "text", time: "")
        
          firestore
            .collection("chatroom")
            .document(getConversationID(senderId: currentUser._id ?? "", receiverId:contactUser._id ?? ""))
            .collection("chats")
            .addDocument(data:message.dictionary) { error in
                if error != nil {
                    self.showAlert(error: error)
                    completion(false)
                }else{
                    completion(true)
                }
            }
            
           
    }
}
