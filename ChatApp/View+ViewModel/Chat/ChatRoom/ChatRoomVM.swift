//
//  ChatRoomVM.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-25.
//
import Foundation
import CoreLocation

class ChatRoomVM: BaseVM {
    
    @Published var textFiled = ""
    
    var currentUser = dummyUse1
    var contactUser = dummyUser2
  
    
    @Published  var sectionsList: [MessageSection] = []
    @Published var lastMessageId: String = ""
    
    init(contactUser: User){
        self.contactUser = contactUser
        self.currentUser = PersistenceController.shared.loadLoclUserType()
    }
}


//load messages
extension ChatRoomVM {
    func fetchData(completion: @escaping CompletionBoolHandler) {
        FirestoreDatabaseManager.shared.getAllMessagesForConversation(senderId: "\(currentUser.id ?? 0)", receiverId:   "\(contactUser.id  ?? 0 )" ) { result in
            switch result {
            case .success(let chatSoucrce):
                self.sectionsList = chatSoucrce.sections
                self.lastMessageId = chatSoucrce.lastMessageId
                self.objectWillChange.send()
                completion(true)
            case .failure(let error):
                self.showAlert(error:error)
                completion(false)
            }
        }
    }
}

//text message
extension ChatRoomVM {
    
    func cleanText(){
        textFiled = ""
        
    }
    
    
    func chatMessage(completion: @escaping CompletionBoolHandler){
        let message = Message(idFrom:  "\(currentUser.id ?? 0)", idTo:"\(contactUser.id  ?? 0 )",message: textFiled, isSeen: false, type: .text)
        FirestoreDatabaseManager.shared.createNewConversation(senderName: currentUser.name ?? "", senderId:  "\(currentUser.id ?? 0)",receiverName:contactUser.name ?? "", receiverId:"\(contactUser.id  ?? 0 )", firstMessage: message) { succes,error in
            if error != nil {
                self.showAlert(error: error)
            }
            print("Status \(succes)")
            completion(succes)
        }
    }
}

//uploadFile message
extension ChatRoomVM {
    
    func uploadFile(fileUrl: URL,fileType:FileTypes,completion: @escaping CompletionBoolHandler){
        switch fileType {
        case .image:
          
            let fileName = "photo_chat_" + UUID().uuidString.replacingOccurrences(of: " ", with: "-") + ".png"
            
            StorageManager.shared.uploadMessagePhoto(with:  fileUrl, fileName: fileName) {  result in
                switch result {
                case .success(let urlString):
                    self.chatMessageWithFile(fileUrl: urlString, fileType: .image) { status in
                        completion(status)
                    }
                case .failure(let error):
                    self.showAlert(error:error)
                    completion(false)
                    break
                }
            }
            break
        case .pdf:
            let fileName = "pdf_chat_" + UUID().uuidString.replacingOccurrences(of: " ", with: "-") + ".pdf"
            StorageManager.shared.uploadMessagePDF(with:  fileUrl, fileName: fileName) {  result in
                switch result {
                case .success(let urlString):
                    self.chatMessageWithFile(fileUrl: urlString, fileType: .pdf) { status in
                        completion(status)
                    }
                case .failure(let error):
                    self.showAlert(error:error)
                    completion(false)
                    break
                }
            }
            break
        }
    }
    
    
    func chatMessageWithFile(fileUrl:String,fileType:MessageTypes,completion: @escaping CompletionBoolHandler){
        
        let media = Media(sourceURL:fileUrl)
        let message = Message(idFrom:  "\(currentUser.id ?? 0)", idTo:  "\(contactUser.id ?? 0)",message: "@Attachment", isSeen: false, type: fileType,media: media)
        
        FirestoreDatabaseManager.shared.createNewConversation(senderName: currentUser.name ?? "", senderId:  "\(currentUser.id ?? 0)",receiverName:contactUser.name ?? "", receiverId:  "\(contactUser.id ?? 0)", firstMessage: message) { succes,error in
            if error != nil {
                self.showAlert(error: error)
            }
            print("Status \(succes)")
            completion(succes)
        }
    }
}


//location message
extension ChatRoomVM {
    
    func chatMessageWithLocation(location: CLLocationCoordinate2D,completion: @escaping CompletionBoolHandler){
        
        let location = Location(locationName: "", latitude: "\(location.latitude)", longitude: "\(location.longitude)")
        let message = Message(idFrom:  "\(currentUser.id ?? 0)", idTo:  "\(contactUser.id ?? 0)",message: "@Location", isSeen: false, type: .location,location: location)
        
        FirestoreDatabaseManager.shared.createNewConversation(senderName: currentUser.name ?? "", senderId:  "\(currentUser.id ?? 0)",receiverName:contactUser.name ?? "", receiverId:  "\(contactUser.id ?? 0)", firstMessage: message) { succes,error in
            if error != nil {
                self.showAlert(error: error)
            }
            print("Status \(succes)")
            completion(succes)
        }
    }
}




extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
