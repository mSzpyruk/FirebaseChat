//
//  ChatViewModel.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 19/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import Foundation

struct ChatViewModel {
    private let chat: Chat
    
    var profileImageUrl: URL? {
        return URL(string: chat.user.profileImageUrl)
    }
    
    var timestamp: String {
        let date = chat.message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    init(chat: Chat) {
        self.chat = chat
    }
}
