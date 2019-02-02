//
//  LoginViewController.swift
//  lovecode
//
//  Created by Pedro Filipe da Rocha Pires on 25/09/2018.
//  Copyright © 2018 inbloom. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonRegister: UIButton!
    
    override func viewDidLoad() {
        var backBtn = UIImage(named: "back")
        backBtn = backBtn?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.navigationController!.navigationBar.backIndicatorImage = backBtn;
        self.navigationController!.navigationBar.backIndicatorTransitionMaskImage = backBtn;
        self.navigationController!.navigationBar.backItem?.title = ""
    }
    
    @IBAction func buttonLoginTouched(_ sender: Any) {
        var message = ""
        if textFieldEmail.text?.isEmpty ?? true
        {
            message += "Campo 'Email' é obrigatório.\n"
        }
        if textFieldPassword.text?.isEmpty ?? true
        {
            message += "Campo 'Password' é obrigatório.\n"
        }
        if !message.isEmpty
        {
            let alert = UIAlertController(title: "Login inválido", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true)
            return
        }

        login(email: textFieldEmail.text!, password: textFieldPassword.text!, viewController: self) { user in
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateInitialViewController()
            self.present(viewController!, animated: true, completion: nil)
            
            //save user in appdelegate
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.user = user
        }
    }
    
    func login(email:String, password:String, viewController:UIViewController, completion: @escaping (User?) -> Void) {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        activityIndicator.startAnimating()
        
        let url = URL(string: "http://lovecode.eneacoaching.com/api/registouser/read.php")
        
        Alamofire.request(url!,
                          method: .post,
                          parameters: ["EmailUser": email, "Password": password],
                          encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                activityIndicator.removeFromSuperview()

                guard response.result.isSuccess else {
                    print(NSString(data: (response.request?.httpBody)!, encoding: String.Encoding.utf8.rawValue)!)
                    
                    let alert = UIAlertController(title: "Erro no Login", message: "Verifique se está conectado à internet ou se a sua password e e-mail estão correctos.", preferredStyle: UIAlertControllerStyle.alert)
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