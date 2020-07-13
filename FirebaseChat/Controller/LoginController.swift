//
//  LoginController.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 13/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "messages-communication-color")
        iv.tintColor = .white
        return iv
    }()
    
    private lazy var emailContainerView: CredentialsTextFieldView = {
        return CredentialsTextFieldView(image: #imageLiteral(resourceName: "email-blend"), textField: emailTextField)
    }()
    
    private lazy var passwordContainerView: CredentialsTextFieldView = {
        return CredentialsTextFieldView(image: #imageLiteral(resourceName: "lock-object-color"), textField: passwordTextField)
    }()
    
    private var emailTextField = CustomTextField(placeholder: "Email")
    
    private var passwordTextField = CustomTextField(placeholder: "Password", isSecureField: true)
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 5
        button.setHeight(height: 50)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .cyan
        return button
    }()
    
    private let goToRegistrationButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 16)])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 16)]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowRegistration), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    //MARK: - Selectors
    
    @objc func handleShowRegistration() {
        
    }
    
    //MARK: - Helpers
    
    fileprivate func configureView() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.backgroundColor = .systemPurple
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view)
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        logoImageView.setDimensions(height: 150, width: 150)
        
        let loginStack = UIStackView(arrangedSubviews: [emailContainerView,
                                                        passwordContainerView,
                                                        loginButton])
        loginStack.axis = .vertical
        loginStack.spacing = 16
        
        view.addSubview(loginStack)
        loginStack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(goToRegistrationButton)
        goToRegistrationButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
    }
}
