//
//  LoginVC.swift
//  Hiking
//
//  Created by MOHAMED on 3/22/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var ConstraintFromRight: NSLayoutConstraint!
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    var MenuIsOpen = false
    override func viewDidLoad() {
        // MARK: - Navigation
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func MenuBu(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuVC
        self.present(vc, animated: true, completion: nil)
        
    }
    func AlertAction(message : String){
        let title  = "خطأ"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "موافق", style: UIAlertActionStyle.cancel, handler:nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func LoginBu(_ sender: Any) {
        guard let email = self.EmailText.text , !email.isEmpty else {
            let message = "يجب عليك إدخال البريد الإلكترونى"
            self.AlertAction(message: message)
            return}
        guard let password = self.PasswordText.text , !password.isEmpty else {
            let message = "يجب عليك إدخال كلمة المرور"
            self.AlertAction(message: message)
            return}
        APIMethods.Login(email: EmailText.text!, password: PasswordText.text!){ (status,message,activationType) in
            if status ==  0 {
                APIMethods.Activation(){type in
                    if type == "sms" {
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SmsActivation")
                        
                        self.present(vc!, animated: true, completion: nil)
                        
                    }else if type == "mail" {
                        let title:String = "إنشاء حساب"
                        
                        let message = "تم إرسال رسالة التفعيل إلى بريدك الإلكترونى"
                        
                        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "موافق", style: UIAlertActionStyle.cancel, handler:nil))
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                    
                }
                
            }else{
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BuildingView") as! CustomTabBarController
                self.present(nextViewController, animated:true, completion:nil)
            }
            
        }
    }
    
    @IBAction func ShareAppBu(_ sender: UIButton) {
        let activityVc = UIActivityViewController(activityItems: [SharingAppUrl], applicationActivities: nil)
        activityVc.popoverPresentationController?.sourceView = self.view
        self.present(activityVc, animated: true, completion: nil)
    }
    @IBAction func LogoutBu(_ sender: UIButton) {
        if let api_token = ApiToken.getApiToken() {
            UserDefaults.standard.removeObject(forKey: "api_token")
            
        }
        
    }
}
