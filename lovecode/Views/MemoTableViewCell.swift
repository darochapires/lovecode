//
//  MemoTableViewCell.swift
//  lovecode
//
//  Created by Pedro Filipe da Rocha Pires on 11/11/2018.
//  Copyright © 2018 inbloom. All rights reserved.
//

import UIKit

class MemoTableViewCell: UITableViewCell {//}, UITextFieldDelegate {
    
    @IBOutlet weak var relationshipTextField: UITextField!
    
    @IBOutlet weak var profileTextField: UITextField!
    
//    var dirty: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        relationshipTextField.delegate = self
//        profileTextField.delegate = self
    }
        
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        dirty = true
//    }
}
