//
//  AlertBuildingVC.swift
//  Hiking
//
//  Created by MOHAMED on 4/23/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit

class AlertBuildingVC: UIViewController {
    var Build_id : Int?
    
    @IBOutlet weak var MainView: UIScrollView!
    @IBOutlet weak var AlertContent: UITextView!
    @IBOutlet weak var AlertTitle: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        var Tap = UITapGestureRecognizer(target: self, action: "CloseWindow")
        // Do any additional setup after loading the view.
        self.MainView.addGestureRecognizer(Tap)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SendAlertBu(_ sender: UIButton) {
        if let api_token = ApiToken.getApiToken() {
            APIMethods.ReportBuilding(Id: Build_id!, api_token: api_token,title: AlertTitle.text! , content: AlertContent.text!)
            let title = "تهانينا"
            let message = " تم إرسال الرساله بنجاح"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "إلغاء", style: UIAlertActionStyle.cancel, handler:nil))
            self.present(alert, animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)

        } else {
            let title = "خطأ"
            let message = " يجب عليك تسجيل الدخول "
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "تسجيل الدخول", style: UIAlertActionStyle.default, handler:{ (actionSheetController) -> Void in
                self.LoginScreen()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func CloseWindow() {
        self.dismiss(animated: true, completion: nil)
    }
    func LoginScreen(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginScreen")
        
        self.present(vc!, animated: true, completion: nil)
    }
}
