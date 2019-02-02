//
//  TestViewController.swift
//  lovecode
//
//  Created by Pedro Filipe da Rocha Pires on 19/09/2018.
//  Copyright © 2018 inbloom. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var ImageView1: UIImageView!
    @IBOutlet weak var ImageView2: UIImageView!
    @IBOutlet weak var ImageView3: UIImageView!    
    @IBOutlet weak var labelPage: UILabel!
    
    var answer1: Int = 0
    var answer2: Int = 0
    var answer3: Int = 0
    
    override func viewDidLoad() {
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 44.0))
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        label.textColor = UIColor.white
        label.text = "Selecione a opção com a qual mais se identifica"
        self.navigationItem.titleView = label
        
        var backBtn = UIImage(named: "back")
        backBtn = backBtn?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.navigationController!.navigationBar.backIndicatorImage = backBtn;
        self.navigationController!.navigationBar.backIndicatorTransitionMaskImage = backBtn;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        answer1 = obtainAnswer1()
        answer2 = obtainAnswer2()
        answer3 = obtainAnswer3()
        
        let count = (UIApplication.shared.delegate as! AppDelegate).testAnswers.count
        let prefix = count == 3 || count == 7 || count == 11 || count == 15 ?
            "n1" : "r"
        ImageView1.image = UIImage(named: prefix + String(answer1))
        ImageView2.image = UIImage(named: prefix + String(answer2))
        ImageView3.image = UIImage(named: prefix + String(answer3))
        
        labelPage.text = String(count + 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParentViewController && (UIApplication.shared.delegate as! AppDelegate).testAnswers.count > 0 {
            (UIApplication.shared.delegate as! AppDelegate).testAnswers.removeLast()
        }
    }
    
    @IBAction func Button1TouchedUpInside(_ sender: Any) {
        self.saveAnswer(answer: answer1)
    }
    
    @IBAction func Button2TouchedUpInside(_ sender: Any) {
        self.saveAnswer(answer: answer2)
    }
    
    @IBAction func Button3TouchedUpInside(_ sender: Any) {
        self.saveAnswer(answer: answer3)
    }
    
    func saveAnswer(answer: Int) -> Void {
        (UIApplication.shared.delegate as! AppDelegate).testAnswers.append(answer % 10)
        
        var viewControllerIdentifier = "TestViewController"
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //go to test four options
        if (UIApplication.shared.delegate as! AppDelegate).testAnswers.count == 16 {
            viewControllerIdentifier = "TestFourOptionsViewController"
        }
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func obtainAnswer1() -> Int {
        let testAnswers = (UIApplication.shared.delegate as! AppDelegate).testAnswers
        let testAnswersCount = testAnswers.count
        var answer = 0
        
        switch testAnswersCount {
        case 0:
            //1º conjunto
            answer = 5
            break
        case 1:
            answer = 7
            break
        case 2:
            answer = 4
            break
        case 3:
            answer = testAnswers[0]
            break
        case 4:
            //2º conjunto
            answer = 23
            break
        case 5:
            answer = 21
            break
        case 6:
            answer = 22
            break
        case 7:
            answer = testAnswers[4]
            break
        case 8:
            //3º conjunto
            answer = 39
            break
        case 9:
            answer = 38
            break
        case 10:
            answer = 31
            break
        case 11:
            answer = testAnswers[8]
            break
        case 12:
            //4º conjunto
            answer = 48
            break
        case 13:
            answer = 47
            break
        case 14:
            answer = 46
            break
        case 15:
            answer = testAnswers[12]
            break
        default:
            break
        }
        return answer
    }
    
    func obtainAnswer2() -> Int {
        let testAnswers = (UIApplication.shared.delegate as! AppDelegate).testAnswers
        let testAnswersCount = testAnswers.count
        var answer = 0
        
        switch testAnswersCount {
        case 0:
            //1º conjunto
            answer = 2
            break
        case 1:
            answer = 1
            break
        case 2:
            answer = 9
            break
        case 3:
            answer = testAnswers[1]
            break
        case 4:
            //2º conjunto
            answer = 29
            break
        case 5:
            answer = 28
            break
        case 6:
            answer = 26
            break
        case 7:
            answer = testAnswers[5]
            break
        case 8:
            //3º conjunto
            answer = 32
            break
        case 9:
            answer = 34
            break
        case 10:
            answer = 33
            break
        case 11:
            answer = testAnswers[9]
            break
        case 12:
            //4º conjunto
            answer = 43
            break
        case 13:
            answer = 41
            break
        case 14:
            answer = 45
            break
        case 15:
            answer = testAnswers[13]
            break
        default:
            break
        }
        return answer
    }
    
    func obtainAnswer3() -> Int {
        let testAnswers = (UIApplication.shared.delegate as! AppDelegate).testAnswers
        let testAnswersCount = testAnswers.count
        var answer = 0
        
        switch testAnswersCount {
        case 0:
            //1º conjunto
            answer = 8
            break
        case 1:
            answer = 6
            break
        case 2:
            answer = 3
            break
        case 3:
            answer = testAnswers[2]
            break
        case 4:
            //2º conjunto
            answer = 27
            break
        case 5:
            answer = 24
            break
        case 6:
            answer = 25
            break
        case 7:
            answer = testAnswers[6]
            break
        case 8:
            //3º conjunto
            answer = 37
            break
        case 9:
            answer = 36
            break
        case 10:
            answer = 35
            break
        case 11:
            answer = testAnswers[10]
            break
        case 12:
            //4º conjunto
            answer = 49
            break
        case 13:
            answer = 44
            break
        case 14:
            answer = 42
            break
        case 15:
            answer = testAnswers[14]
            break
        default:
            break
        }
        return answer
    }
}
