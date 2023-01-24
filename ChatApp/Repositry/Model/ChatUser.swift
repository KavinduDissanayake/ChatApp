//
//  ChatUser.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-16.
//

import Foundation
import SwiftDate


// MARK: - ChatUser
struct ChatUser: Codable {
    let connection, connectionName, lastMessage: String?
    let lastTime,totalUnread:Int?
    enum CodingKeys: String, CodingKey {
        case connection, connectionName, lastMessage
        case totalUnread = "total_unread"
        case lastTime
    }
    
    func getMessageTime() -> String{
        let time = DateInRegion(milliseconds: lastTime ?? 0, region: .current).toFormat("hh:mm a")
        return time
    }
}

