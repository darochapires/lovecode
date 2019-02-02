//
//  EditProfileViewController.swift
//  lovecode
//
//  Created by Pedro Filipe da Rocha Pires on 04/12/2018.
//  Copyright © 2018 inbloom. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldOldPassword: UITextField!
    @IBOutlet weak var textFieldNewPassword: UITextField!
    @IBOutlet weak var textFieldReenterNewPassword: UITextField!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var viewOldPassword: UIView!
    @IBOutlet weak var viewNewPassword: UIView!
    @IBOutlet weak var viewReenterNewPassword: UIView!
    
    override func viewDidLoad() {
        let delegate = (UIApplication.shared.delegate as! AppDelegate)
        textFieldName.text = delegate.user?.name
        textFieldEmail.text = delegate.user?.email
    }
    
    @IBAction func buttonPasswordTouched(_ sender: Any) {
        viewPassword.isHidden = true
        viewOldPassword.isHidden = false
        viewNewPassword.isHidden = false
        viewReenterNewPassword.isHidden = false
    }
    
    func login(email:String, password:String, viewController:UIViewController, completion: @escaping (User?) -> Void) {
        let url = URL(string: "http://lovecode.eneacoaching.com/api/registouser/read.php")
        
        Alamofire.request(url!,
                          method: .post,
                          parameters: ["EmailUser": email, "Password": password],
                          encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print(NSString(data: (response.request?.httpBody)!, encoding: String.Encoding.utf8.rawValue)!)
                    
                    let alert = UIAlertController(title: "Erro no Login", message: "A password ou e-mail estão errados.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK",  style: UIAlertActionStyle.default, handler: nil))
                    viewController.present(alert, animated: true)
                    return
                }
                var user = User(userId: "", name: "", email: "", profileId: 0)
                if let data = response.data {
                    let dataJson = JSON(data)["data"]
                    let json = String(data: data, encoding: String.Encoding.utf8)
                    user = User(userId: dataJson["IdUser"].stringValue, name: dataJson["NomeUser"].stringValue, email: dataJson["EmailUser"].stringValue, profileId: dataJson["IdPerfil"].intValue)
                    print("jsonzzz: \(json)")
                }
                completion(user)
        }
    }
    
}
