//
//  ConversationsController.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 13/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "ConversationCell"

class ConversationsController: UIViewController {
    
    //MARK: - Properties
    
    private let tableView = UITableView()
    
    private var chats = [Chat]()
    private var chatsDict = [String: Chat]()

    
    private let newChatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemPink
        button.tintColor = .white
        button.imageView?.setDimensions(height: 24, width: 24)
        button.addTarget(self, action: #selector(showNewChat), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        checkIfUserIsLogged()
        fetchChats()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        configureNavigationBar(withTitle: "Chat Rooms", prefersLargeTitles: true)
    }
    
    //MARK: - API
    
    func fetchChats() {
        FirebaseService.shared.fetchChats { (chats) in
            chats.forEach { (chat) in
                let message = chat.message
                self.chatsDict[message.chattingWith] = chat
            }
            self.chats = Array(self.chatsDict.values)
            self.tableView.reloadData()
        }
    }
    
    func checkIfUserIsLogged() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            presentLoginScreen()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Selectors
    
    @objc func showProfile() {
        let controller = ProfileController(style: .insetGrouped)
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    @objc func showNewChat() {
        let controller = NewChatController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    //MARK: - Helpers
    
    func presentLoginScreen() {
        DispatchQueue.main.async {
            let controller = LoginController()
            controller.delegate = self
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    //MARK: - Helper - Configure View
    
    fileprivate func configureView() {
        view.backgroundColor = .white
        
        configureTableView()
        
        view.addSubview(newChatButton)
        newChatButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 16, paddingRight: 32, width: 56, height: 56)
        newChatButton.layer.cornerRadius = 56 / 2
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle.fill"), style: .plain, target: self, action: #selector(showProfile))
        
    }
    
    //MARK: - Helper - Configure Table View
    
    fileprivate func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.register(ChatCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
}

//MARK: - TableViewDataSource

extension ConversationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ChatCell
        cell.chat = chats[indexPath.row]
        return cell
    }
}

//MARK: - TableViewDelegate

extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = chats[indexPath.row].user
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - NewChatControllerDelegate

extension ConversationsController: NewChatControllerDelegate {
    func controller(_ controller: NewChatController, wantsToChatWith user: User) {
        controller.dismiss(animated: true, completion: nil)
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ConversationsController: ProfileControllerDelegate {
    func handleLogout() {
        logOut()
    }
}

extension ConversationsController: AuthDelegate {
    func authComplete() {
        dismiss(animated: true, completion: nil)
        configureView()
        fetchChats()
    }
}
