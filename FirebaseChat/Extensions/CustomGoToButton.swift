//
//  CustomGoToButton.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 14/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import UIKit

class CustomGoToButton: UIButton {
    
    init(placeholder: String, actionString: String) {
        super.init(frame: .zero)
        
        
        let attributedTitle = NSMutableAttributedString(string: "\(placeholder) ", attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 16)])
        attributedTitle.append(NSAttributedString(string: actionString, attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 16)]))
        
        setAttributedTitle(attributedTitle, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
