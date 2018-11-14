//
//  StoryVC.swift
//  escapeRoom
//
//  Created by 이동기 on 29/10/2018.
//  Copyright © 2018 이동기. All rights reserved.
//

import UIKit

class StoryVC: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblStory: UILabel!
    
    var count = 0
    var completeorNot = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ud = UserDefaults.standard
        ud.set("fail", forKey: "success")

        btnBack.isEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        switch count {
        case 0:
            lblStory.text = "교실문이 열려져 있던 덕에 나는 USB와 친구의 휴대폰을 쉽게 찾을 수 있었다. 이제 다시 집으로 가려던 순간 늦은 밤 내가 교실에 있다는걸 알 리가 없던 수위아저씨는 학교 문을 잠가버렸다."
            btnBack.isEnabled = true
            count += 1
        case 1:
            lblStory.text = "지금은 과제 제출까지 40분 전, 집까지 가는데 20분, 과제를 제출하는데 10분이 걸릴것을 생각하면 10분안에 이곳을 탈출해야한다."
            count += 1
        case 2:
            let alertController = UIAlertController(title: "주의", message: "완료를 누르는 순간부터 시간이 체크됩니다", preferredStyle: UIAlertController.Style.alert)
            
            let registerAction = UIAlertAction(title: "완료", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                let storyboard: UIStoryboard = self.storyboard!
                let nextView = storyboard.instantiateViewController(withIdentifier: "currentTimvVC")
                self.present(nextView, animated: true, completion: nil)
            }
            let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.default)
            
            alertController.addAction(cancelAction)
            alertController.addAction(registerAction)
            
            self.present(alertController, animated: true, completion: nil)
        default:
            lblStory.text = "오류"
        }
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        switch count {
        case 1:
            lblStory.text = "지금은 오후 11시, 과제 제출 1시간 전, 나는 과제가 들어있는 USB를 교실에 두고 온 것을 깨달았다. 놓고 온 자신의 휴대폰을 들고와달라는 친구의 말과 함께 나는 늦은 밤 학교로 향한다."
            btnBack.isEnabled = false
        case 2:
            lblStory.text = "교실문이 열려져 있던 덕에 나는 USB와 친구의 휴대폰을 쉽게 찾을 수 있었다. 이제 다시 집으로 가려던 순간 늦은 밤 내가 교실에 있다는걸 알 리가 없던 수위아저씨는 학교 문을 잠가버렸다."
        default:
            lblStory.text = "오류"
        }
        count -= 1
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
