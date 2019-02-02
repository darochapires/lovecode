//
//  MemoViewController.swift
//  lovecode
//
//  Created by Pedro Filipe da Rocha Pires on 05/11/2018.
//  Copyright © 2018 inbloom. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MemoViewController: UITableViewController {

    var memoList = [Memo]()

    override func viewWillAppear(_ animated: Bool) {
        fetchMemos(viewController: self) { memoList in
            self.memoList = memoList!
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        for rowIndex in 0 ..< tableView.numberOfRows(inSection: 0) {
            let cell = tableView.cellForRow(at: IndexPath(row: rowIndex, section: 0)) as! MemoTableViewCell
            if !cell.relationshipTextField.text!.isEmpty && !cell.profileTextField.text!.isEmpty {
                let relationship = cell.relationshipTextField.text!
                let profileId = Int(cell.profileTextField.text!)!
                
                //compare relationship and profileId with cell's. if differente, sand to server
                if memoList.count > rowIndex {
                    let memo = memoList[rowIndex]
                    if relationship != memo.relationship || profileId != memo.profileId {
                        setMemo(userId: 3, relationship: relationship, profileId: String(profileId))
                    }
                }
                else {
                    setMemo(userId: 3, relationship: relationship, profileId: String(profileId))
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoTableViewCell", for: indexPath) as! MemoTableViewCell
        if memoList.count > indexPath.row {
            let memo = memoList[indexPath.row]
            cell.relationshipTextField.text = memo.relationship
            cell.profileTextField.text = String(memo.profileId)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(red:0.33, green:0.12, blue:0.16, alpha:1)
    }
    
    func fetchMemos(viewController:UIViewController, completion: @escaping ([Memo]?) -> Void) {
        let url = URL(string: "http://lovecode.eneacoaching.com/api/memo/read.php")
        Alamofire.request(url!,
                          method: .get)
            .validate()
            .responseJSON { response in
                
                guard response.result.isSuccess,
                    let value = response.result.value else {
                        print("Error while fetching memos: \(String(describing: response.result.error))")
                        completion(nil)
                        return
                }
                
                let memoList = (JSON(value)["registos"].array?.map { json -> Memo in
                    Memo(memoId: json["IdMemo"].intValue,
                         relationship:  json["Parentesco"].stringValue,
                         userId: json["IdUser"].intValue,
                         profileId: json["IdPerfil"].intValue)
                    })!
                completion(memoList)
        }
    }
    
    func setMemo(userId:Int, relationship:String, profileId:String) {
        let url = URL(string: "http://lovecode.eneacoaching.com/api/memo/create.php")
        Alamofire.request(url!,
                          method: .post,
                          parameters: ["IdUser": userId, "Parentesco": relationship, "IdPerfil": profileId],
                          encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print(NSString(data: (response.request?.httpBody)!, encoding: String.Encoding.utf8.rawValue)!)
                    
                    let alert = UIAlertController(title: "Erro na memorização", message: "Ocorreu um erro na memorização de relacionamento. Por favor, tente novamente.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK",  style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
        }
    }
}
