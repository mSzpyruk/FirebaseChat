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
    
   static func uploadMessage(_ message: String, user: User, completion: ((Error?) -> Void)?) {
        guard let currentUser = Auth.auth().currentUser?.uid else { return }
        
        let data = ["text": message,
                    "fromUser": currentUser,
                    "toUser": user.uid,
                    "timestamp": Timestamp(date: Date())] as [String: Any]
        
        Firestore.firestore().collection("messages").document(currentUser).collection(user.uid).addDocument(data: data) { (_) in
            Firestore.firestore().collection("messages").document(user.uid).collection(currentUser).addDocument(data: data, completion: completion)
        }
    }
}
