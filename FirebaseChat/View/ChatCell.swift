//
//  ChatCell.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 19/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    //MARK: - Properties
    
    var chat: Chat? {
        didSet {
            guard let chat = chat else { return }
            
            let viewModel = ChatViewModel(chat: chat)
            nicknameLabel.text = chat.user.nickname
            messageLabel.text = chat.message.text
            
            timestampLabel.text = viewModel.timestamp
            profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        }
    }
    
    let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    let timestampLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.text = "24h"
        return label
    }()
    
    let nicknameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let messageLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor, paddingLeft: 12, width: 50, height: 50)
        profileImageView.layer.cornerRadius = 50 / 2
        profileImageView.centerY(inView: self)
        
        let stack = UIStackView(arrangedSubviews: [nicknameLabel, messageLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerY(inView: profileImageView)
        stack.anchor(left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12)
        
        addSubview(timestampLabel)
        timestampLabel.anchor(top: topAnchor, right: rightAnchor, paddingTop: 24, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
