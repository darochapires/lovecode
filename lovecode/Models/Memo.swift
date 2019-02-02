//
//  Memo.swift
//  lovecode
//
//  Created by Pedro Filipe da Rocha Pires on 04/11/2018.
//  Copyright © 2018 inbloom. All rights reserved.
//

import Foundation

class Memo {
    
    var memoId: Int
    var relationship: String
    var userId: Int
    var profileId: Int
    
    init(memoId: Int, relationship: String, userId: Int, profileId: Int) {
        self.memoId = memoId
        self.relationship = relationship
        self.userId = userId
        self.profileId = profileId
    }
}
