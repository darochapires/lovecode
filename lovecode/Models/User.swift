//
//  User.swift
//  lovecode
//
//  Created by Pedro Filipe da Rocha Pires on 29/10/2018.
//  Copyright © 2018 inbloom. All rights reserved.
//

import Foundation

class User {
    
    var userId: String
    var name: String
    var email: String
    var profileId: Int
    
    init(userId: String, name: String, email: String, profileId: Int) {
        self.userId = userId
        self.name = name
        self.email = email
        self.profileId = profileId
    }
}
