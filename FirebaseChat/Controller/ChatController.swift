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
    
    private lazy var inputBar: InputView = {
        let ib = InputView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 50))
        return ib
    }()
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
    
    override var inputAccessoryView: UIView? {
        get { return inputBar }
    }
    
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        collectionView.backgroundColor = .white
        configureNavigationBar(withTitle: user.nickname, prefersLargeTitles: false)

    }
}
