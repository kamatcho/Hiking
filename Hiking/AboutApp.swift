//
//  AboutApp.swift
//  Hiking
//
//  Created by MOHAMED on 3/30/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class AboutApp: UIViewController{
    
    @IBOutlet weak var TitleText: UILabel!
    
    @IBOutlet weak var ContentText: UITextView!
    
    var MenuIsOpen = false
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        SetItems()
    }
    
    @IBAction func MenuBu(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuVC
        self.present(vc, animated: true, completion: nil)
    }
    




func SetItems(){
    let url = URL(string: PagesAppUrl)!
    let parametes = [
        "id" :3
    ]
    Alamofire.request(url, method: .get, parameters: parametes, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
        switch response.result {
        case .failure(let error):
            print(error)
            print(error)
        case .success(let value):
            let json = JSON(value)
            if let page = json["page"].dictionary{
                if let active = page["active"]?.int {
                    if active == 1 {
                        if let name = page["name"]?.string{
                            self.TitleText.text = name
                            
                        }
                        if let content = page["name"]?.string{
                            self.ContentText.text = content
                        }
                        
                    }
                }
            }
            print(value)
            
        }
    }
}



}
