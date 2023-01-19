//
//  MessageSection.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-19.
//

import Foundation


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
