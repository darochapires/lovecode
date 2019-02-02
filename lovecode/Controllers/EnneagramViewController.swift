//
//  EnneagramViewController.swift
//  lovecode
//
//  Created by Pedro Filipe da Rocha Pires on 19/09/2018.
//  Copyright © 2018 inbloom. All rights reserved.
//

import UIKit

class EnneagramViewController: UIViewController {

    override func viewDidLoad() {
        var backBtn = UIImage(named: "back")
        backBtn = backBtn?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.navigationController!.navigationBar.backIndicatorImage = backBtn;
        self.navigationController!.navigationBar.backIndicatorTransitionMaskImage = backBtn;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
}
