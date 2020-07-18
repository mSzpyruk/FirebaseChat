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
    
    static func fetchMessages(forUser user: User, completion: @escaping([Message]) -> Void) {
        var messages = [Message]()
        guard let currentUser = Auth.auth().currentUser?.uid else { return }
        
        let query = Firestore.firestore().collection("messages").document(currentUser).collection(user.uid).order(by: "timestamp")
        
        query.addSnapshotListener { (snapshot, error) in
            snapshot?.documentChanges.forEach({ (change) in
                if change.type == .added {
                    let dictionary = change.document.data()
                    messages.append(Message(dictionary: dictionary))
                    completion(messages)
                }
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
