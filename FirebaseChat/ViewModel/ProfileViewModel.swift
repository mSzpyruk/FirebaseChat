//
//  ProfileViewModel.swift
//  FirebaseChat
//
//  Created by Michał Szpyruk on 19/07/2020.
//  Copyright © 2020 Michał Szpyruk. All rights reserved.
//

import Foundation

enum ProfileViewModel: Int, CaseIterable {
    case accountInfo
    
    var description: String {
        switch self {
        case .accountInfo: return "Acount Info"
        }
    }
    
    var iconImageName: String {
       switch self {
        case .accountInfo: return "person.circle"
        }
    }
}
