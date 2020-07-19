//
//  Service.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 14/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import UIKit
import Firebase

struct RegistrationCredentials {
    let email: String
    let fullname: String
    let nickname: String
    let password: String
    let profileImage: UIImage
}

struct Service {
    static let shared = Service()
    
    
    func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func logUserOut(credentials: RegistrationCredentials, completion: ((Error?) -> Void)?) {
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.4) else { return }
        let filename = NSUUID().uuidString
        let reference = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        reference.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                completion!(error)
                return
            }
            
            reference.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                    if let error = error {
                        completion!(error)
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    let data = ["email": credentials.email,
                                "fulname": credentials.fullname,
                                "nickname": credentials.nickname,
                                "profileImageUrl": profileImageUrl,
                                "uid": uid] as [String: Any]
                    
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                }
            }
        }
    }
}
