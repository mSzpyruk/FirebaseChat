//
//  LoginController.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 13/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

protocol AuthDelegate: class {
    func authComplete()
}

class LoginController: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate: AuthDelegate?
    
    var viewModel = LoginViewModel()
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "chat")
        return iv
    }()
    
    private let mainLabel: UILabel = {
       let label = UILabel()
        let attributedLabel = NSMutableAttributedString(string: "Proceed with your\n", attributes: [.foregroundColor: UIColor.primaryText, .font: UIFont.systemFont(ofSize: 30, weight: .thin)])
        attributedLabel.append(NSAttributedString(string: "Login", attributes: [.foregroundColor: UIColor.primaryText, .font: UIFont.systemFont(ofSize: 36, weight: .bold)]))
        label.attributedText = attributedLabel
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var emailContainerView: CredentialsTextFieldView = {
        return CredentialsTextFieldView(image: #imageLiteral(resourceName: "email-blue"), textField: emailTextField)
    }()
    
    private lazy var passwordContainerView: CredentialsTextFieldView = {
        return CredentialsTextFieldView(image: #imageLiteral(resourceName: "key-object-color"), textField: passwordTextField)
    }()
    
    private var emailTextField = CustomTextField(placeholder: "Email")
    private var passwordTextField = CustomTextField(placeholder: "Password", isSecureField: true)
    
    private let loginButton: CustomAuthButton = {
        let button = CustomAuthButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(handleUserLogIn), for: .touchUpInside)
        return button
    }()
    
    private let goToRegistrationButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [.foregroundColor: UIColor.secondaryTextColor, .font: UIFont.systemFont(ofSize: 16)])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [.foregroundColor: UIColor.primaryPurple, .font: UIFont.boldSystemFont(ofSize: 16)]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowRegistration), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureNotificationObservers()
    }
    
    //MARK: - API
    
    @objc func handleUserLogIn() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        showProgressLoader(true, withText: "Logging in")
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                self.showProgressLoader(false)
                return
            }
            self.showProgressLoader(false)
            self.delegate?.authComplete()
        }
    }
    
    //MARK: - Selectors
    

    @objc func handleShowRegistration() {
        let controller = RegistrationController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChange(_ sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        updateForm()
    }
    
    @objc func keyboardShow() {
        if view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 88
        }
    }
    
    @objc func keyboardHide() {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    //MARK: - Helpers
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func updateForm() {
        loginButton.isEnabled = viewModel.shouldEnableButton
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    }
    
    //MARK: - Helper - Configure View

    fileprivate func configureView() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.backgroundColor = .white
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view)
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        logoImageView.setDimensions(height: 200, width: 200)
        
        view.addSubview(mainLabel)
        mainLabel.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, paddingTop: 32, paddingLeft: 32)
        
        let loginStack = UIStackView(arrangedSubviews: [emailContainerView,
                                                        passwordContainerView,
                                                        loginButton])
        loginStack.axis = .vertical
        loginStack.spacing = 16
        
        view.addSubview(loginStack)
        loginStack.anchor(top: mainLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(goToRegistrationButton)
        goToRegistrationButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingBottom: 16 , paddingRight: 32)
    }
}
