//
//  PersonalityProfileViewController.swift
//  lovecode
//
//  Created by Pedro Filipe da Rocha Pires on 18/10/2018.
//  Copyright © 2018 inbloom. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PersonalityProfileViewController: UIViewController {

    @IBOutlet weak var labelNumber: UILabel!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var LabelTextTitle: UILabel!
    
    @IBOutlet weak var LabelTextInformation: UILabel!
    
    @IBOutlet weak var ImageViewBottom: UIImageView!
    
    var personalityProfile = PersonalityProfile(profileId: 0, descriptionOne: "", descriptionTwo: "", text: "")
    
    var number = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Selecione a opção com a qual mais se identifica"
        self.title = "Selecciona a opção com a qual mais se identifica"
        
        if personalityProfile.profileId != 0 {
            setScreen()
        } else {
            let delegate = (UIApplication.shared.delegate as! AppDelegate)
            if delegate.profilesList == nil {
                fetchProfiles() { profilesList in
                    delegate.profilesList = profilesList
                    self.personalityProfile = delegate.profilesList![self.number - 1]
                    self.setScreen()
                }
            } else {
                self.personalityProfile = delegate.profilesList![self.number - 1]
                self.setScreen()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParentViewController && (UIApplication.shared.delegate as! AppDelegate).testAnswers.count > 0 {
            (UIApplication.shared.delegate as! AppDelegate).testAnswers.removeAll()
            navigationController?.popToRootViewController(animated: true)
        }
    }

    func setScreen() -> Void {
        labelNumber.text = String(number)
        labelTitle.text = personalityProfile.descriptionTwo
        LabelTextInformation.text = personalityProfile.text
    }
    
    func fetchProfiles(completion: @escaping ([PersonalityProfile]?) -> Void) {
        let url = URL(string: "http://lovecode.eneacoaching.com/api/perfil/read.php")
        
        Alamofire.request(url!, method: .get)
            .validate()
            .responseJSON { response in
                
                guard response.result.isSuccess,
                    let value = response.result.value else {
                        print("Error while fetching profiles: \(String(describing: response.result.error))")
                        completion(nil)
                        return
                }
                
                let profilesList = (JSON(value)["registos"].array?.map { json -> PersonalityProfile in
                    PersonalityProfile(profileId: json["IdPerfil"].intValue,
                                       descriptionOne: json["Descricao1"].stringValue,
                                       descriptionTwo:  json["Descricao2"].stringValue,
                                       text:  json["Texto"].stringValue)
                    })!
                completion(profilesList)
        }
    }
}
