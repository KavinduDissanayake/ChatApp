//
//  ChatDataSource.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-31.
//

import Foundation
import SwiftDate
import Combine

class ChatDataSource {
    var sections: [MessageSection] = []
    var allMessages: [Message] = []
    
    public func addMessage(message:Message){

        let title = DateInRegion(milliseconds: message.time, region: .current).toFormat("dd MMM, YYYY")


        if !allMessages.contains(where: { $0.id == message.id} ) {
            if let firstIndex = sections.firstIndex(where: {$0.title == title}) {
                sections[firstIndex].messages.append(message)
                allMessages.append(message)
            }else{
                //found new date groupe
                //add new section
                var newSection = MessageSection(title, createdAt: message.time)
                    newSection.messages.append(message)
                    allMessages.append(message)
                    sections.append(newSection)
            }
        }

    }

    public func addMessages(messages:[Message]){
        sections = []
        for message in messages {
                addMessage(message: message)
        }

        sections.sort(by: {$0.createdAt ?? 0 < $1.createdAt ?? 0})
        for index in 0..<sections.count{
            sections[index].messages.sort(by: { $0.time  < $1.time })
        }
    }
    
}


