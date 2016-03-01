//
//  ChatTableViewModel.swift
//  ChatMessageParser
//
//  Created by Ahmed Abdurrahman on 3/1/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//

import Foundation

enum MessageType {
    case Mine
    case Reply
}

struct Message {
    var message: String
    var type: MessageType
}

class ChatTableViewModel {

    var messages = [Message]()
    
    func addMessage(message: String, type: MessageType){
        messages.append(Message(message: message, type: type))
    }
    
    func addDummyMessages(){
        messages.append(Message(message: "hi", type: .Mine))
        messages.append(Message(message: "hi2", type: .Reply))
        messages.append(Message(message: "hi3", type: .Reply))
        messages.append(Message(message: "hi4", type: .Mine))
        messages.append(Message(message: "hi5", type: .Reply))
        messages.append(Message(message: "hi6", type: .Mine))
        messages.append(Message(message: "hi7", type: .Reply))
    }
}