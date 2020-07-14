//
//  FirebaseService.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 14/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import Firebase

struct FirebaseService {
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
            snapshot?.documents.forEach({ (document) in
                
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                users.append(user)
                completion(users)
            })
        }
    }
}
