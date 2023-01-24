//  Message.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-19.
//

import Foundation
import SwiftDate
import FirebaseFirestore



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
    
    
}//
