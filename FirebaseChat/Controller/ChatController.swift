//
//  ChatController.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 15/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import UIKit

class ChatController: UICollectionViewController {
    
    //MARK: - Properties
    
    private let user: User
    
    
    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        collectionView.backgroundColor = .yellow
    }
}
