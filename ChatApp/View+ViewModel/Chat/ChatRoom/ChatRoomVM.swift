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
import FirebaseStorage
import CoreLocation



public struct MessageSection: Codable,Identifiable,Equatable {
    
    public static func == (lhs: MessageSection, rhs: MessageSection) -> Bool {
        return lhs.id == rhs.id
    }
    

    
    public var id = UUID()    
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



enum MessageTypes: String {
    case text = "text"
    case image = "image"
    case pdf = "pdf"
    case location = "location"
}

struct Message:Identifiable,Codable {
    var id: String = UUID().uuidString  // @DocumentID to fetch the identifier from Firestore
    var idFrom = ""
    var idTo = ""
    var message = ""
    var isSeen = false
    var type:MessageTypes = .text
    var time = 0
    var media :Media?
    var location :Location?
    
    enum CodingKeys: String, CodingKey {
        case media
        case location
    }
    
    
    var dictionary:[String:Any]{
       return [
            "idFrom":idFrom,
            "idTo":idTo,
            "message":message,
            "isSeen":isSeen,
            "type":type.rawValue,
            "time":FieldValue.serverTimestamp(),
            "media":[
                "source_url":media?.sourceURL
            ],
            "location":[
                "latitude":location?.latitude,
                "longitude":location?.longitude
            ]
        ]
    }
    
    func getMessageTime() -> String{
        let time = DateInRegion(milliseconds: time, region: .current).toFormat("hh:mm a")
        return time
    }
    
    
}

struct Media: Codable {
    var sourceURL: String
    enum CodingKeys: String, CodingKey {
        case sourceURL = "source_url"
    }
}

struct Location: Codable {
    var locationName: String
    var latitude: String
    var longitude: String
    enum CodingKeys: String, CodingKey {
        case locationName = "locationName"
        case latitude = "latitude"
        case longitude = "longitude"
    }
}


class ChatRoomVM: BaseVM {
    
    @Published var textFiled = ""
    
    var currentUser = dummyUse1
    var contactUser = dummyUser2
    var firestore = Firestore.firestore()
    
    @Published  var sectionsList: [MessageSection] = []
}



//load messages
extension ChatRoomVM {
    func fetchData(completion: @escaping CompletionBoolHandler) {
        FirestoreDatabaseManager.shared.getAllMessagesForConversation(senderId: currentUser._id ?? "", receiverId:  contactUser._id ?? "") { result in
            switch result {
            case .success(let sectionsList):
                self.sectionsList = sectionsList
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
    
    func chatMessage(completion: @escaping CompletionBoolHandler){
        let message = Message(idFrom: currentUser._id ?? "", idTo: contactUser._id ?? "",message: textFiled, isSeen: false, type: .text)
        FirestoreDatabaseManager.shared.createNewConversation(senderName: currentUser.firstName ?? "", senderId: currentUser._id ?? "",receiverName:contactUser.firstName ?? "", receiverId: contactUser._id ?? "", firstMessage: message) { succes,error in
            if error != nil {
                self.showAlert(error: error)
            }
            print("Status \(succes)")
            completion(succes)
        }
    }
}

enum FileTypes: String {
    case image = "image"
    case pdf = "pdf"
}
//uploadFile message
extension ChatRoomVM {
    
    func uploadFile(fileUrl: URL,fileType:FileTypes,completion: @escaping CompletionBoolHandler){
        switch fileType {
        case .image:
            let fileName = "photo_chat_" + UUID().uuidString.replacingOccurrences(of: " ", with: "-") + ".png"
            StorageManager.shared.uploadMessagePhoto(with:  fileUrl.dataRepresentation, fileName: fileName) {  result in
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
            StorageManager.shared.uploadMessagePDF(with:  fileUrl.dataRepresentation, fileName: fileName) {  result in
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
        let message = Message(idFrom: currentUser._id ?? "", idTo: contactUser._id ?? "",message: "@Attachment", isSeen: false, type: fileType,media: media)
        
        FirestoreDatabaseManager.shared.createNewConversation(senderName: currentUser.firstName ?? "", senderId: currentUser._id ?? "",receiverName:contactUser.firstName ?? "", receiverId: contactUser._id ?? "", firstMessage: message) { succes,error in
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
