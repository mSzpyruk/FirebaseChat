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

class LoginController: UIViewController {
    
    //MARK: - Properties
    
    var viewModel = LoginViewModel()
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "speech bubbles (rounded)-communication-color")
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
    
    private let loginButton: CustomAuthButton = {
        let button = CustomAuthButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(handleUserLogIn), for: .touchUpInside)
        return button
    }()
    
    private let goToRegistrationButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [.foregroundColor: UIColor.darkGray, .font: UIFont.systemFont(ofSize: 16)])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [.foregroundColor: UIColor.red, .font: UIFont.boldSystemFont(ofSize: 16)]))
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
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: - Selectors
    

    @objc func handleShowRegistration() {
        navigationController?.pushViewController(RegistrationController(), animated: true)
    }
    
    @objc func textDidChange(_ sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        updateForm()
    }
    
    //MARK: - Helpers
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
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
