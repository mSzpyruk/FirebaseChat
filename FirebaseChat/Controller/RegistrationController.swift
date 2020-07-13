//
//  RegistrationController.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 13/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    //MARK: - Properties
    
    private let photoPickerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "camera-border").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: CredentialsTextFieldView = {
        return CredentialsTextFieldView(image: #imageLiteral(resourceName: "email-blend"), textField: emailTextField)
    }()
    
    private var emailTextField = CustomTextField(placeholder: "Email")
    
    private lazy var fullnameContainerView: CredentialsTextFieldView = {
        return CredentialsTextFieldView(image: #imageLiteral(resourceName: "profile-blue"), textField: fullnameTextField)
    }()
    
    private var fullnameTextField = CustomTextField(placeholder: "Full Name")

    private lazy var nicknameContainerView: CredentialsTextFieldView = {
        return CredentialsTextFieldView(image: #imageLiteral(resourceName: "user-user-color"), textField: nicknameTextField)
    }()
    private var nicknameTextField = CustomTextField(placeholder: "Nickname")

    private lazy var passwordContainerView: CredentialsTextFieldView = {
        return CredentialsTextFieldView(image: #imageLiteral(resourceName: "lock-object-color"), textField: passwordTextField)
    }()
    
    private var passwordTextField = CustomTextField(placeholder: "Password", isSecureField: true)

    private let registrationButton: CustomAuthButton = {
    let button = CustomAuthButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(#colorLiteral(red: 0.2705882353, green: 0.5218564868, blue: 0.7714765668, alpha: 1), for: .normal)
        return button
    }()
    
    private let goToLoginButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 16)])
        attributedTitle.append(NSAttributedString(string: "Log In", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 16)]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    //MARK: - Selectors
    
    @objc func handleSelectPhoto() {
        
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    
    fileprivate func configureView() {
        view.backgroundColor = .systemPurple

        view.addSubview(photoPickerButton)
        photoPickerButton.centerX(inView: view)
        photoPickerButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        photoPickerButton.setDimensions(height: 200, width: 200)
        
        let registrationStack = UIStackView(arrangedSubviews: [emailContainerView,
                                                        fullnameContainerView,
                                                        nicknameContainerView,
                                                        passwordContainerView,
                                                        registrationButton])
        registrationStack.axis = .vertical
        registrationStack.spacing = 16
        
        view.addSubview(registrationStack)
        registrationStack.anchor(top: photoPickerButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(goToLoginButton)
        goToLoginButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        }
}
