//
//  MessageCell.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 16/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var message: Message? {
        didSet {
            configure()
        }
    }
    
    var textLeftSide: NSLayoutConstraint!
    var textRightSide: NSLayoutConstraint!
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .white
        return tv
    }()
    
    private let messageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        return view
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 8)
        profileImageView.setDimensions(height: 32, width: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        
        addSubview(messageContainer)
        messageContainer.layer.cornerRadius = 12
        messageContainer.anchor(top: topAnchor, bottom: bottomAnchor)
        messageContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        textLeftSide = messageContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
        textLeftSide.isActive = false

        textRightSide = messageContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        textRightSide.isActive = false

        messageContainer.addSubview(textView)
        textView.anchor(top: messageContainer.topAnchor, left: messageContainer.leftAnchor, bottom: messageContainer.bottomAnchor, right: messageContainer.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 4, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configure() {
        guard let message = message else { return }
        let viewModel = MessageViewModel(message: message)
        messageContainer.backgroundColor = viewModel.messageBackgroundColor
        textView.textColor = viewModel.messageTextColor
        textView.text = message.text
        
        textLeftSide.isActive = viewModel.leftTextSide
        textRightSide.isActive = viewModel.rightTextSide
        
        profileImageView.isHidden = viewModel.shouldHideProfileImage
    }
}
