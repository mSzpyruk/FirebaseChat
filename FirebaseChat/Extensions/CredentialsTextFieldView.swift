//
//  CredentialsTextFieldView.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 13/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import UIKit

class CredentialsTextFieldView: UIView {
    
    init(image: UIImage?, textField: UITextField) {
        super.init(frame: .zero)
        
        setHeight(height: 50)
        
        let iv = UIImageView()
        iv.image = image
        iv.tintColor = .white
        iv.alpha = 0.85
        
        addSubview(iv)
        iv.centerY(inView: self)
        iv.anchor(right: rightAnchor, paddingRight: 8)
        iv.setDimensions(height: 24, width: 24)
        
        addSubview(textField)
        textField.centerY(inView: self)
        textField.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 4)
        
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = .dividerColor
        addSubview(bottomBorder)
        bottomBorder.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 4, paddingRight: 4, height: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
