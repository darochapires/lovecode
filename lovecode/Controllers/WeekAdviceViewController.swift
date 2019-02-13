//
//  WeekAdviceViewController.swift
//  lovecode
//
//  Created by Pedro Filipe da Rocha Pires on 02/02/2019.
//  Copyright © 2019 inbloom. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeekAdviceViewController : UIViewController {
    
    @IBOutlet weak var labelAdvice: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let idProfile = appDelegate.user?.profileId
        
        getAdvice(profileId: idProfile!, viewController: self) { advice in
            self.labelAdvice.text = advice
        }
    }
    
    func getAdvice(profileId:Int, viewController:UIViewController, completion: @escaping (String?) -> Void) {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        activityIndicator.startAnimating()
        
        let url = URL(string: "http://lovecode.eneacoaching.com/api/dicasemana/read.php")
        
        Alamofire.request(url!,
                          method: .post,
                          parameters: ["IdPerfil": profileId],
                          encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                activityIndicator.removeFromSuperview()
                
                guard response.result.isSuccess else {
                    print(NSString(data: (response.request?.httpBody)!, encoding: String.Encoding.utf8.rawValue)!)
                    
                    let alert = UIAlertController(title: "", message: "Verifique se já realizou o teste de Eneagrama.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK",  style: UIAlertActionStyle.default, handler: nil))
                    viewController.present(alert, animated: true)
                    return
                }
                var advice = ""
                if let data = response.data {
                    let dataJson = JSON(data)["registos"][0]
                    let json = String(data: data, encoding: String.Encoding.utf8)
                    advice = dataJson["DicaSemana"].stringValue
                    print("jsonzzz: \(json)")
                }
                completion(advice)
        }
    }
}
