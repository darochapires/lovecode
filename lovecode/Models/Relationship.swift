//
//  Relationship.swift
//  lovecode
//
//  Created by Pedro Filipe da Rocha Pires on 04/11/2018.
//  Copyright © 2018 inbloom. All rights reserved.
//

import Foundation

class Relationship {
    
    var relationshipId: Int
    var text: String
    var profileIdOne: String
    var profileIdTwo: String
    
    init(relationshipId: Int, text: String, profileIdOne: String, profileIdTwo: String) {
        self.relationshipId = relationshipId
        self.text = text
        self.profileIdOne = profileIdOne
        self.profileIdTwo = profileIdTwo
    }
}
