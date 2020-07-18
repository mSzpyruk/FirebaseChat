//
//  MessageViewModel.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 16/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import UIKit

struct MessageViewModel {
    
    private let message: Message
    
    
    var messageBackgroundColor: UIColor {
        return message.isFromCurrentUser ? .lightGray : .systemBlue
    }
    
    var messageTextColor: UIColor {
        return message.isFromCurrentUser ? .black : .white
    }
    
    var rightTextSide: Bool {
        return message.isFromCurrentUser
    }
    
    var leftTextSide: Bool {
        return !message.isFromCurrentUser
    }
    
    var shouldHideProfileImage: Bool {
        return message.isFromCurrentUser
    }
    
    var profileImageUrl: URL? {
        guard let user = message.user else { return nil }
        return URL(string: user.profileImageUrl)
    }
    
    init(message: Message) {
        self.message = message
    }
}
