//
//  ChooseProfileViewController.swift
//  lovecode
//
//  Created by Pedro Filipe da Rocha Pires on 23/11/2018.
//  Copyright © 2018 inbloom. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class ChooseProfileViewController: UITableViewController {
    
    var profilesList = [PersonalityProfile]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (UIApplication.shared.delegate as! AppDelegate).profilesList == nil {
            fetchProfiles(viewController: self) { profilesList in
                self.profilesList = profilesList!
                self.tableView.reloadData()
                (UIApplication.shared.delegate as! AppDelegate).profilesList = self.profilesList
            }
        }
        else {
            self.profilesList = (UIApplication.shared.delegate as! AppDelegate).profilesList!
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profilesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalityProfileTableViewCell", for: indexPath) as! PersonalityProfileTableViewCell
        
        cell.labelNumber.text = String(indexPath.row + 1)
        cell.labelTitle.text = profilesList[indexPath.row].descriptionTwo
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 47
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(red:0.33, green:0.12, blue:0.16, alpha:1)
        
        let n: Int! = self.navigationController?.viewControllers.count
        let myUIViewController = self.navigationController?.viewControllers[n-2] as! RelationshipsViewController
        myUIViewController.chosenProfileId = indexPath.row + 1
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func fetchProfiles(viewController:UIViewController, completion: @escaping ([PersonalityProfile]?) -> Void) {
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
