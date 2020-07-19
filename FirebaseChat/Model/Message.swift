//
//  Message.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 16/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import Firebase

struct Message {
    var user: User?
    
    let text: String
    let toUser: String
    let fromUser: String
    var timestamp: Timestamp!
    let isFromCurrentUser: Bool
    
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.toUser = dictionary["toUser"] as? String ?? ""
        self.fromUser = dictionary["fromUser"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())

        self.isFromCurrentUser = fromUser == Auth.auth().currentUser?.uid
    }
}

struct Chat {
    let user: User
    let message: Message
}
