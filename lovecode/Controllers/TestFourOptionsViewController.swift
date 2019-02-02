//
//  TestFourOptionsViewController.swift
//  lovecode
//
//  Created by Pedro Filipe da Rocha Pires on 30/11/2018.
//  Copyright © 2018 inbloom. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TestFourOptionsViewController: UIViewController {
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var viewDown: UIView!
    @IBOutlet weak var viewContainer: UIView!
    
    @IBOutlet weak var LabelPage: UILabel!
    
    override func viewDidLoad() {
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 44.0))
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        label.textColor = UIColor.white
        label.text = "Selecione a opção com a qual mais se identifica"
        self.navigationItem.titleView = label
    }

    override func viewWillAppear(_ animated: Bool) {
        let testAnswers = (UIApplication.shared.delegate as! AppDelegate).testAnswers
        
        if testAnswers.count >= 18 {
            //this means view came back from PersonalityProfileViewController
            (UIApplication.shared.delegate as! AppDelegate).testAnswers.removeLast()
        }
        if testAnswers.count == 16 {
            imageView1.image = UIImage(named: "n2" + String(testAnswers[3]) + "quadrado")
            var filledSpaces = 1
            if(testAnswers[7] != testAnswers[3]) {
                imageView2.image = UIImage(named: "n2" + String(testAnswers[7]) + "quadrado")
                filledSpaces += 1
            }
            if testAnswers[11] != testAnswers[3] && testAnswers[11] != testAnswers[7] {
                let image = UIImage(named: "n2" + String(testAnswers[11]) + "quadrado")
                if filledSpaces == 1 {
                    imageView2.image = image
                }
                else if filledSpaces == 2 {
                    imageView3.image = image
                }
                filledSpaces += 1
            }
            if testAnswers[15] != testAnswers[3] && testAnswers[15] != testAnswers[7]  && testAnswers[15] != testAnswers[11] {
                let image = UIImage(named: "n2" + String(testAnswers[15]) + "quadrado")
                if filledSpaces == 1 {
                    imageView2.image = image
                }
                else if filledSpaces == 2 {
                    imageView3.image = image
                }
                else if filledSpaces == 3 {
                    imageView4.image = image
                }
                filledSpaces += 1
            }
            if filledSpaces == 1 {
                imageView2.image = UIImage(named: "n2" +
                    String(obtainAnswerForSingleAnswer(answer: testAnswers[3]))
                    + "quadrado")
                filledSpaces += 1
            }
            if filledSpaces == 2 {
                viewDown.isHidden = true
            } else if filledSpaces == 3 {
                imageView4.isHidden = true
                button4.isHidden = true
            }
        }
        else if testAnswers.count == 17 {
            imageView1.image = UIImage(named: "n3" + String(testAnswers[16]) + "quadrado")
            imageView2.image = UIImage(named: "n3" + String(obtainAnswerForSingleAnswer(answer: testAnswers[16])) + "quadrado")
            viewContainer.backgroundColor = UIColor.clear
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParentViewController {
            if (UIApplication.shared.delegate as! AppDelegate).testAnswers.count > 0 {
                (UIApplication.shared.delegate as! AppDelegate).testAnswers.removeLast()
            }
        }
    }
    
    @IBAction func Button1TouchedUpInside(_ sender: Any) {
        saveAnswer(answer: 3)
    }
    
    @IBAction func Button2TouchedUpInside(_ sender: Any) {
        saveAnswer(answer: 7)
    }
    
    @IBAction func Button3TouchedUpInside(_ sender: Any) {
        saveAnswer(answer: 11)
    }
    
    @IBAction func Button4TouchedUpInside(_ sender: Any) {
        saveAnswer(answer: 15)
    }
    
    func obtainAnswerForSingleAnswer(answer: Int) -> Int {
        var secondAnswer = 0
        switch answer {
        case 1:
            secondAnswer = 6
            break
        case 2:
            secondAnswer = 4
            break
        case 3:
            secondAnswer = 8
            break
        case 4:
            secondAnswer = 1
            break
        case 5:
            secondAnswer = 9
            break
        case 6:
            secondAnswer = 8
            break
        case 7:
            secondAnswer = 3
            break
        case 8:
            secondAnswer = 3
            break
        case 9:
            secondAnswer = 5
            break
        default:
            break
        }
        return secondAnswer
    }
    
    func saveAnswer(answer: Int) -> Void {
        let chosenAnswerProfileId = (UIApplication.shared.delegate as! AppDelegate).testAnswers[answer] % 10
        (UIApplication.shared.delegate as! AppDelegate).testAnswers.append(chosenAnswerProfileId)
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var identifier = "TestFourOptionsViewController"
        if (UIApplication.shared.delegate as! AppDelegate).testAnswers.count == 18 {
            identifier = "PersonalityProfileViewController"
        }
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        if viewController is PersonalityProfileViewController {
            setTest(userId: (UIApplication.shared.delegate as! AppDelegate).user!.userId, profileId: chosenAnswerProfileId, viewController: self) {
                (UIApplication.shared.delegate as! AppDelegate).testAnswers.append(chosenAnswerProfileId)
                (UIApplication.shared.delegate as! AppDelegate).user?.profileId = chosenAnswerProfileId
                (viewController as! PersonalityProfileViewController).number = chosenAnswerProfileId
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        } else {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func setTest(userId:String, profileId:Int, viewController:UIViewController,completion: @escaping () -> Void) {
        let url = URL(string: "http://lovecode.eneacoaching.com/api/setteste/update.php")
        
        Alamofire.request(url!,
                          method: .post,
                          parameters: ["IdUser": userId, "IdPerfil": profileId])
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print(NSString(data: (response.request?.httpBody)!, encoding: String.Encoding.utf8.rawValue)!)
                    
                    let alert = UIAlertController(title: "Erro no Teste", message: "Ocorreu um erro ao terminar teste. Por favor, tente mais tarde.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK",  style: UIAlertActionStyle.default, handler: nil))
                    viewController.present(alert, animated: true)
                    (UIApplication.shared.delegate as! AppDelegate).testAnswers.removeLast()
                    return
                }
                completion()
        }
    }
}
