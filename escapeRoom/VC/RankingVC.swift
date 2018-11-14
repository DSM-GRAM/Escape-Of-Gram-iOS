//
//  RankingVC.swift
//  escapeRoom
//
//  Created by 이동기 on 25/10/2018.
//  Copyright © 2018 이동기. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class RankingVC: UIViewController {
    var rankingArray = [ranking]()
    var modelReference = [ranking]()
    var count = 0
    var shortTime = ""
    
    @IBOutlet var lblNames: [UILabel]!
    @IBOutlet var lblTimes: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ud = UserDefaults.standard
        ud.set("registered", forKey: "success")
        
        callAPI()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnRedo(_ sender: Any) {
        callAPI()
    }
    
    func callAPI() {
        let parameters = ["name": "값","time":"값"]
        
        Alamofire.request("http://13.59.116.83/rank", parameters: parameters, encoding: URLEncoding(destination: .httpBody)).responseData { (response) in
            
            if let data = response.data, let _ = String(data: data, encoding: .utf8) {
                
                let jsonSerialization = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
                
                print("\(jsonSerialization)")
                
                
                
                for i in 0...4 {
                    if jsonSerialization.count > i {
                        self.rankingArray.append(ranking.init(name: jsonSerialization[i]["name"] as! String, time: jsonSerialization[i]["time"] as! String))
                        print(i)
                        print(self.rankingArray[i].name)
                        
                        let txt = self.rankingArray[i].time
                        
                        print(txt[txt.index(txt.startIndex, offsetBy: 3)...])
                        
                        self.shortTime = String(txt[txt.index(txt.startIndex, offsetBy: 3)...])
                        
                        self.lblNames[i].text = self.rankingArray[i].name
                        self.lblTimes[i].text = self.shortTime
                        
                        self.lblNames[i].textColor = UIColor.white
                        self.lblTimes[i].textColor = UIColor.white
                    } else {
                        break
                    }
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class ranking {
    var name: String
    var time: String
    
    init(name: String, time: String) {
        self.name = name
        self.time = time
    }
}
