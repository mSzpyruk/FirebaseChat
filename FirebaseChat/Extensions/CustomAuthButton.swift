//
//  CustomAuthButton.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 13/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import UIKit

class CustomAuthButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 3
        backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.768627451, blue: 0.9137254902, alpha: 1).withAlphaComponent(0.5)
        setHeight(height: 50)
        isEnabled = false
        setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
