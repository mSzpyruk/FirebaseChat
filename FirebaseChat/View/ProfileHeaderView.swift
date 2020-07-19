//
//  ProfileHeaderView.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 19/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import UIKit

protocol ProfileHeaderViewDelegate: class {
    func dismissProfile()
}

class ProfileHeaderView: UIView {
    
    //MARK: - Properties
    
    var user: User? {
        didSet {
            configure()
        }
    }
    
    weak var delegate: ProfileHeaderViewDelegate?
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.imageView?.setDimensions(height: 24, width: 24)
        return button
    }()
    
    private let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.borderColor = UIColor.black.cgColor
        iv.layer.borderWidth = 1
        return iv
    }()
    
    private let fullnameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "asd"
        return label
    }()
    
    private let nicknameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "asd"

        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleDismiss() {
        
    }
    
    //MARK: - Helper - Configure View
    
    func configureView() {
        backgroundColor = .white

        profileImageView.setDimensions(height: 200, width: 200)
        profileImageView.layer.cornerRadius = 200 / 2
        
        addSubview(profileImageView)
        profileImageView.centerX(inView: self)
        profileImageView.anchor(top: topAnchor, paddingTop: 80)
        
        let stack = UIStackView(arrangedSubviews: [fullnameLabel, nicknameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: profileImageView.bottomAnchor, paddingTop: 12)
        
        addSubview(dismissButton)
        dismissButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 36, paddingLeft: 12)
        dismissButton.setDimensions(height: 48, width: 48)
    }
    
    //MARK: - Helpers
    
    func configure() {
        guard let user = user else { return }
        guard let url = URL(string: user.profileImageUrl) else { return }

        fullnameLabel.text = user.fullname
        nicknameLabel.text = user.nickname        
        profileImageView.sd_setImage(with: url)
    }
}
