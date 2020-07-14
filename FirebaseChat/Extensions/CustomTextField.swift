//
//  CustomTextField.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 13/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String, isSecureField: Bool? = false) {
        super.init(frame: .zero)
        
        keyboardAppearance = .dark
        borderStyle = .none
        textColor = .black
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.lightGray])
        isSecureTextEntry = isSecureField!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
