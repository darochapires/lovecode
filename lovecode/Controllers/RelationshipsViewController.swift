//
//  RelationshipsViewController.swift
//  lovecode
//
//  Created by Pedro Filipe da Rocha Pires on 15/11/2018.
//  Copyright © 2018 inbloom. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RelationshipsViewController: UIViewController {

    @IBOutlet weak var ViewWrapper: UIView!
    @IBOutlet weak var labelProfileId: UILabel!
    @IBOutlet weak var labelChooseProfileId: UILabel!
    @IBOutlet weak var buttonChooseProfile: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelText: UILabel!
    
    var chosenProfileId = Int()
    var userProfileId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileId = (UIApplication.shared.delegate as! AppDelegate).user?.profileId
        if let prodileIdValue = profileId, prodileIdValue > 0 {
            labelProfileId.text = String(prodileIdValue)
            userProfileId = String(prodileIdValue)
        }
        
        var backBtn = UIImage(named: "back")
        backBtn = backBtn?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.navigationController!.navigationBar.backIndicatorImage = backBtn;
        self.navigationController!.navigationBar.backIndicatorTransitionMaskImage = backBtn;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        labelChooseProfileId.text = chosenProfileId == 0 ? "?" : String(chosenProfileId)
        
        if chosenProfileId != 0 {
            fetchRelationship(profileId1: userProfileId, profileId2: String(chosenProfileId)) { relationship in
                self.labelText.text = relationship?.text
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        labelText.text = ""
    }
    
    func fetchRelationship(profileId1:String, profileId2:String, completion: @escaping (Relationship?) -> Void) {
        let url = URL(string: "http://lovecode.eneacoaching.com/api/relacionamento/read.php")
        
        Alamofire.request(url!, method: .post,
                          parameters: ["IdPerfil_1": profileId1, "IdPerfil_2": profileId2],
                          encoding: JSONEncoding.default)
            .validate()
            .responseString { response in
                
                guard response.result.isSuccess,
                    let _ = response.result.value else {
                        print("Error while fetching relationship: \(String(describing: response.result.error))")
                        completion(nil)
                        return
                }
                
                var relationship = Relationship(relationshipId: 0, text: "", profileIdOne: "0", profileIdTwo: "0")
                if let data = response.data {
                    let dataJson = JSON(data)
                    let json = String(data: data, encoding: String.Encoding.utf8)
                    relationship = Relationship(relationshipId: dataJson["IdRelacionamento"].intValue, text: dataJson["Texto"].stringValue, profileIdOne: dataJson["IdPerfil_1"].stringValue, profileIdTwo: dataJson["IdPerfil_2"].stringValue)
                    print("json relationship: \(json ?? "")")
                }
                completion(relationship)
        }
    }
}
