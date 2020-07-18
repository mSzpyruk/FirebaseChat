//
//  ChatController.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 15/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import UIKit



private let reuseIdentifier = "MessageCell"
class ChatController: UICollectionViewController {
    
    //MARK: - Properties
    
    private let user: User
    private var messages = [Message]()
    var fromCurrentUser = false
    
    
    private lazy var inputBar: InputView = {
        let ib = InputView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 50))
        ib.delegate = self
        return ib
    }()
    
    override var inputAccessoryView: UIView? {
        get { return inputBar }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    //MARK: - Init
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchMessages()
    }
    
    //MARK: - API
    
    func fetchMessages() {
        FirebaseService.fetchMessages(forUser: user) { (messages) in
            self.messages = messages
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        collectionView.backgroundColor = .white
        configureNavigationBar(withTitle: user.nickname, prefersLargeTitles: false)
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

//MARK: - TableViewDataSource

extension ChatController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        cell.message = messages[indexPath.row]
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ChatController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let cellSize = MessageCell(frame: frame)
        cellSize.message = messages[indexPath.row]
        cellSize.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedCellSize = cellSize.systemLayoutSizeFitting(targetSize)
        
        return .init(width: view.frame.width, height: estimatedCellSize.height)
    }
}

//MARK: - InputViewDelegate

extension ChatController: InputViewDelegate {
    func inputView(_ inputView: InputView, wantsToSend message: String) {
        fromCurrentUser.toggle()
        
        FirebaseService.uploadMessage(message, user: user) { (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            inputView.messageInputView.text = ""
        }
    }
}
