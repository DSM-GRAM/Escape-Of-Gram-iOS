//
//  registerRankVC.swift
//  escapeRoom
//
//  Created by 이동기 on 31/10/2018.
//  Copyright © 2018 이동기. All rights reserved.
//

import UIKit

class registerRankVC: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblCompletTime: UILabel!
    
    var paramMin = ""
    var paramSec = ""
    var minute = 0
    var second = 0
    var time = ""
    var rankingArray = [ranking]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(paramMin + paramSec)
        
        minute = Int(paramMin)!
        second = Int(paramSec)!
        
        showTimer()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        if txtName.text == "Your Name!" || txtName.text == "" {
            let alertController = UIAlertController(title: "주의", message: "이름을 입력하세요", preferredStyle: UIAlertController.Style.alert)
            
            let registerAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
            
            alertController.addAction(registerAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "등록", message: "확인버튼을 누르면 등록합니다", preferredStyle: UIAlertController.Style.alert)
            
            let registerAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                self.callAPI()
                let storyboard: UIStoryboard = self.storyboard!
                let nextView = storyboard.instantiateViewController(withIdentifier: "rankingVC")
                self.present(nextView, animated: true, completion: nil)
            }
            let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.default)
            
            alertController.addAction(cancelAction)
            alertController.addAction(registerAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func showTimer() {
        time = String(format: "%02d:%02d", minute, second)
        lblCompletTime.text = time
    }
    
    
    func callAPI() {
        let parameters = ["name": txtName.text!, "time": time] as [String : Any]

        //create the url with URL
        let url = URL(string: "http://13.59.116.83/rank")!

        //create the session object
        let session = URLSession.shared

        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")


        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

            do {
                //create json object from data
                print("success")
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func getRequest(dictionary: [String: String]){
        rankingArray.append(ranking.init(name: dictionary["name"]!, time: dictionary["time"]!))
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
