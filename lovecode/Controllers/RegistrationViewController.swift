//
//  RegistrationViewController.swift
//  lovecode
//
//  Created by Pedro Filipe da Rocha Pires on 24/09/2018.
//  Copyright © 2018 inbloom. All rights reserved.
//

import UIKit
import Alamofire

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldRepeatPassword: UITextField!
    @IBOutlet weak var buttonRegister: UIButton!
    @IBOutlet weak var switchPrivacy: UISwitch!
    
    @IBAction func buttonRegisterTouched(_ sender: Any) {
        var message = ""
        if textFieldName.text?.isEmpty ?? true
        {
            message = "Campo 'Nome' é obrigatório.\n"
        }
        if textFieldEmail.text?.isEmpty ?? true
        {
            message += "Campo 'Email' é obrigatório.\n"
        }
        if textFieldPassword.text?.isEmpty ?? true
        {
            message += "Campo 'Password' é obrigatório.\n"
        }
        if textFieldRepeatPassword.text?.isEmpty ?? true
        {
            message += "Campo 'Repetir Password' é obrigatório.\n"
        }
        else if textFieldRepeatPassword.text != textFieldPassword.text
        {
            message += "As passwords inseridas devem ser iguais.\n"
        }
        if !switchPrivacy.isOn
        {
            message += "Tem de tomar conhecimento das Política de Privacidade.\n"
        }
        if !message.isEmpty
        {
            let alert = UIAlertController(title: "Registo inválido", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true)
            return
        }
        register(name: textFieldName.text!, email: textFieldEmail.text!, password: textFieldPassword.text!, viewController: self)
    }
    
    @IBAction func ButtonLoginTouchedUpInside(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func register(name:String, email:String, password:String, viewController:UIViewController) {
        let url = URL(string: "http://lovecode.eneacoaching.com/api/registouser/create.php")
        
        Alamofire.request(url!,
                          method: .post,
                          parameters: ["NomeUser": name, "EmailUser": email, "Password": password, "IdPerfil": "1"],
                          encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print(NSString(data: (response.request?.httpBody)!, encoding: String.Encoding.utf8.rawValue)!)
                    
                    let alert = UIAlertController(title: "Erro no Registo", message: "Ocorreu um erro no registo. Por favor, tente mais tarde.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK",  style: UIAlertActionStyle.default, handler: nil))
                    viewController.present(alert, animated: true)
                    return
                }
                let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
                let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                viewController.present(loginViewController, animated: true, completion: nil)
        }
    }
}
