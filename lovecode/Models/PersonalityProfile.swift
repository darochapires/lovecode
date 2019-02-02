//
//  PersonalityProfile.swift
//  lovecode
//
//  Created by Pedro Filipe da Rocha Pires on 15/10/2018.
//  Copyright © 2018 inbloom. All rights reserved.
//

import Foundation

class PersonalityProfile {
    
    var profileId: Int
    var descriptionOne: String
    var descriptionTwo: String
    var text: String

    init(profileId: Int, descriptionOne: String, descriptionTwo: String, text: String) {
        self.profileId = profileId
        self.descriptionOne = descriptionOne
        self.descriptionTwo = descriptionTwo
        self.text = text
    }
}
