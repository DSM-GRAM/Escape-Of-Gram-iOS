//
//  PasswordVC.swift
//  escapeRoom
//
//  Created by 이동기 on 31/10/2018.
//  Copyright © 2018 이동기. All rights reserved.
//

import UIKit

class PasswordVC: UIViewController {

    @IBOutlet weak var lblFirstWord: UILabel!
    @IBOutlet weak var lblSecondWord: UILabel!
    @IBOutlet weak var lblThirdWord: UILabel!
    @IBOutlet weak var lblFourthWord: UILabel!
    
    var count = 0
    var password = 1147
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnUnwind(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnOne(_ sender: Any) {
        checkandInsert(num: 1)
    }
    
    @IBAction func btnTwo(_ sender: Any) {
        checkandInsert(num: 2)
    }
    
    @IBAction func btnThree(_ sender: Any) {
        checkandInsert(num: 3)
    }
    
    @IBAction func btnFour(_ sender: Any) {
        checkandInsert(num: 4)
    }
    
    @IBAction func btnFive(_ sender: Any) {
        checkandInsert(num: 5)
    }
    
    @IBAction func btnSix(_ sender: Any) {
        checkandInsert(num: 6)
    }
    
    @IBAction func btnSeven(_ sender: Any) {
        checkandInsert(num: 7)
    }
    
    @IBAction func btnEight(_ sender: Any) {
        checkandInsert(num: 8)
    }
    
    @IBAction func btnNine(_ sender: Any) {
        checkandInsert(num: 9)
    }
    
    @IBAction func btnZero(_ sender: Any) {
        checkandInsert(num: 0)
    }
    
    func checkandInsert(num: Int) {
        switch count {
        case 0:
            lblFirstWord.text = String(num)
            count += 1
        case 1:
            lblSecondWord.text = String(num)
            count += 1
        case 2:
            lblThirdWord.text = String(num)
            count += 1
        default:
            lblFourthWord.text = String(num)
            if lblFirstWord.text == "1" && lblSecondWord.text == "1" && lblThirdWord.text == "1" && lblFourthWord.text == "1" {
                let alertController = UIAlertController(title: "축하합니다", message: "문이 열렸습니다", preferredStyle: UIAlertController.Style.alert)
                
                let cancelAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                    let ud = UserDefaults.standard
                    ud.set("success", forKey: "success")
                    
                    self.dismiss(animated: true, completion: nil)
                }
                
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "틀렸습니다", message: "다시 시도하세요", preferredStyle: UIAlertController.Style.alert)
                
                let cancelAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
                }
                
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
