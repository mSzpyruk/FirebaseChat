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
    
    private let messageTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .white
        return tv
    }()
    
    private let messageContainerView: UIView = {
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
        
        addSubview(messageContainerView)
        messageContainerView.layer.cornerRadius = 12
        messageContainerView.anchor(top: topAnchor, bottom: bottomAnchor)
        messageContainerView.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        textLeftSide = messageContainerView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
        textLeftSide.isActive = false

        textRightSide = messageContainerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        textRightSide.isActive = false

        messageContainerView.addSubview(messageTextView)
        messageTextView.anchor(top: messageContainerView.topAnchor, left: messageContainerView.leftAnchor, bottom: messageContainerView.bottomAnchor, right: messageContainerView.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 4, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configure() {
        guard let message = message else { return }
        let viewModel = MessageViewModel(message: message)
        messageContainerView.backgroundColor = viewModel.messageBackgroundColor
        messageTextView.textColor = viewModel.messageTextColor
        messageTextView.text = message.text
        
        textLeftSide.isActive = viewModel.leftTextSide
        textRightSide.isActive = viewModel.rightTextSide
        
        profileImageView.isHidden = viewModel.shouldHideProfileImage
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    }
}
