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
    }
    
    //MARK: - API
    
    func checkIfUserIsLogged() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
        } else {
            print(123)
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            presentLoginScreen()
        } catch {
            print("logged out")
        }
    }
    
    //MARK: - Selectors
    
    @objc func showProfile() {
        logOut()
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
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    //MARK: - Helper - Configure View
    
    fileprivate func configureView() {
        view.backgroundColor = .white
        
        configureNavigationBar(withTitle: "Chat Rooms", prefersLargeTitles: true)
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
}

//MARK: - TableViewDataSource

extension ConversationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = "cell"
        return cell
    }
}

//MARK: - TableViewDelegate

extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

//MARK: - NewChatControllerDelegate

extension ConversationsController: NewChatControllerDelegate {
    func controller(_ controller: NewChatController, wantsToChatWith user: User) {
        controller.dismiss(animated: true, completion: nil)
        let chat = ChatController(user: user)
        navigationController?.pushViewController(chat, animated: true)
    }
}
