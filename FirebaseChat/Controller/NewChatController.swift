//
//  NewChatController.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 14/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import UIKit

private let reuseIdentifier = "UserCell"

protocol NewChatControllerDelegate: class {
    func controller(_ controller: NewChatController, wantsToChatWith user: User)
}

class NewChatController: UITableViewController {
    
    //MARK: - Properties
    
    private var users = [User]()

    weak var delegate: NewChatControllerDelegate?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTableView()
        fetchUsers()
    }
    
    //MARK: - API
    
    func fetchUsers() {
        FirebaseService.fetchUsers { (users) in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Selectors
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Helper - Configure View
    
    fileprivate func configureView() {
        configureNavigationBar(withTitle: "New Chat", prefersLargeTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
    }
    
    //MARK: - Helper - Configure Table View
    
    fileprivate func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
    }
}

//MARK: - TableViewDataSource

extension NewChatController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        return cell
    }
}

//MARK: - TableViewDelegate

extension NewChatController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.controller(self, wantsToChatWith: users[indexPath.row])
    }
}
