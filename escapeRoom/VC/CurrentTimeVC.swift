//
//  CurrentTimeVC.swift
//  escapeRoom
//
//  Created by 이동기 on 25/10/2018.
//  Copyright © 2018 이동기. All rights reserved.
//

import UIKit

class CurrentTimeVC: UIViewController {
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var btnFirstHint: UIButton!
    @IBOutlet weak var btnSecondHint: UIButton!
    @IBOutlet weak var btnThirdHint: UIButton!
    @IBOutlet weak var lblHint: UILabel!
    @IBOutlet weak var imgHint: UIImageView!
    @IBOutlet weak var btnCancel: UIButton!
    
    var counter = 0
    var timer = Timer()
    var miuteTimer = Timer()
    var isPlaying = false
    var minute = 0
    var time = ""
    var completeorNot = "fail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblCurrentTime.text = "00 : 00"
        
        btnFirstHint.isEnabled = false
        btnSecondHint.isEnabled = false
        btnThirdHint.isEnabled = false
        
        showHint(hidden: true)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isPlaying = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let ud = UserDefaults.standard
        
        if let success = ud.string(forKey: "success") {
            print(success)
            completeorNot = success
        }
        
        switch completeorNot {
        case "success":
            isPlaying = false
            
            guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "registerRankVC") as? registerRankVC else {
                return
            }
            
            rvc.paramMin = String(minute)
            rvc.paramSec = String(counter)
            
            self.present(rvc, animated: true)
        case "registered":
            isPlaying = false
            
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier: "rankingVC")
            self.present(nextView, animated: true, completion: nil)
        default:
            print("정상 시작")
        }
    }
    
    @IBAction func btnGiveup(_ sender: Any) {
        let alertController = UIAlertController(title: "주의", message: """
        정말 포기하시겠습니까?
        (기록은 저장되지 않습니다)
        """, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "예", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            self.isPlaying = false
            
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier: "failVC")
            self.present(nextView, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "아니요", style: UIAlertAction.Style.default)
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btnCalcelAction(_ sender: Any) {
        showHint(hidden: true)
    }
    
    @IBAction func btnFirstHint(_ sender: Any) {
        lblHint.text = "당신은 항상 노트북 비밀번호를 까먹은적이 많았다. 그래서 메모를 해둔 기억이 난다. 책상밑이 어둡다"
        showHint(hidden: false)
        btnFirstHint.setImage(UIImage(named: "hintBasic.png"), for: .normal)
    }
    
    @IBAction func btnSecondHint(_ sender: Any) {
        lblHint.text = "사람들의 연락처정보는 항상 내 USB에 있었다."
        showHint(hidden: false)
        btnSecondHint.setImage(UIImage(named: "hintBasic.png"), for: .normal)
    }
    
    @IBAction func btnThirdHint(_ sender: Any) {
        showHint(hidden: false)
        lblHint.text = "그녀와의 추억을 생각해보자."
        btnThirdHint.setImage(UIImage(named: "hintBasic.png"), for: .normal)
    }
    
    @objc func updateTimer() {
        if isPlaying == true {
            counter += 1
            if counter % 60 == 0 {
                minute += 1
                counter = 0
            }
            time = String(format: "%02d : %02d", minute, counter)
            lblCurrentTime.text = time
            
            giveHint()
        }
    }

    func giveHint() {
        let checking = counter + minute * 60
        if checking == 90 {
            btnFirstHint.isEnabled = true
            btnFirstHint.setImage(UIImage(named: "hintAble.png"), for: .normal)
        } else if checking == 180 {
            btnSecondHint.isEnabled = true
            btnSecondHint.setImage(UIImage(named: "hintAble.png"), for: .normal)
        } else if checking == 270 {
            btnThirdHint.isEnabled = true
            btnThirdHint.setImage(UIImage(named: "hintAble.png"), for: .normal)
        } else if checking >= 590 {
            if checking % 2 == 1 {
                lblCurrentTime.textColor = UIColor.red
            } else {
                lblCurrentTime.textColor = UIColor.white
            }
        } else if checking == 600 {
            isPlaying = false
        }
    }
    
    func showHint(hidden: Bool) {
        if hidden == true {
            lblHint.isHidden = true
            imgHint.isHidden = true
            btnCancel.isHidden = true
        } else {
            lblHint.isHidden = false
            imgHint.isHidden = false
            btnCancel.isHidden = false
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
