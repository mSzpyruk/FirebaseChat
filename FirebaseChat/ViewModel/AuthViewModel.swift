//
//  AuthViewModel.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 13/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import UIKit

protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
    var shouldEnableButton: Bool { get }
    var buttonTitleColor: UIColor { get }
    var buttonBackgroundColor: UIColor { get }
}

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false &&
            password?.isEmpty == false
    }
    
    var shouldEnableButton: Bool {
        return formIsValid
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    
    var buttonBackgroundColor: UIColor {
        let enabledColor = #colorLiteral(red: 0.4039215686, green: 0.2274509804, blue: 0.7176470588, alpha: 1)
        let disabledColor = #colorLiteral(red: 0.8196078431, green: 0.768627451, blue: 0.9137254902, alpha: 1).withAlphaComponent(0.5)
        return formIsValid ? enabledColor : disabledColor
    }
    
}

struct RegistrationViewModel: AuthenticationViewModel {
    var email: String?
    var fullname: String?
    var nickname: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false &&
            fullname?.isEmpty == false &&
            nickname?.isEmpty == false &&
            password?.isEmpty == false
    }
    
    var shouldEnableButton: Bool {
        return formIsValid
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    
    var buttonBackgroundColor: UIColor {
        let enabledColor = #colorLiteral(red: 0.8500421047, green: 0.3497924209, blue: 0.3478696346, alpha: 1)
        let disabledColor = #colorLiteral(red: 0.9214009643, green: 0.534648478, blue: 0.5309287906, alpha: 1).withAlphaComponent(0.5)
        return formIsValid ? enabledColor : disabledColor
    }
    
}
