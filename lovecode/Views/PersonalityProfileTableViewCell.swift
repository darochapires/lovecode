//
//  PersonalityProfileTableViewCell.swift
//  lovecode
//
//  Created by Pedro Filipe da Rocha Pires on 15/10/2018.
//  Copyright © 2018 inbloom. All rights reserved.
//

import UIKit

class PersonalityProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var labelNumber: UILabel!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
