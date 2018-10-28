//
//  UserAccountVC.swift
//  Hiking
//
//  Created by MOHAMED on 4/8/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserAccountVC: UIViewController {
    
    @IBOutlet weak var PasswordText: AMTextField!
    @IBOutlet weak var MobilteText: AMTextField!
    @IBOutlet weak var EmailText: AMTextField!
    @IBOutlet weak var UserNameText: AMTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setItems()
    }
    
    public func setItems (){
        if let api_token = ApiToken.getApiToken() {
            APIMethods.UserData(api_token: api_token) { (error , name , email , mobile) in
                self.UserNameText.text = name
                self.EmailText.text = email
                
                self.MobilteText.text = mobile
                
            }
        } else {
            let title  = "خطأ"
            let message = "أنت تحتاج إلى تسجيل الدخول أولا"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "إلغاء", style: UIAlertActionStyle.cancel, handler:nil))
            alert.addAction(UIAlertAction(title: "تسجيل الدخول", style: UIAlertActionStyle.default, handler:{ (actionSheetController) -> Void in
                self.LoginScreen()
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func LoginScreen(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginScreen")
        
        self.present(vc!, animated: true, completion: nil)
    }
    func AlertAction(message : String){
        let title  = "خطأ"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "موافق", style: UIAlertActionStyle.cancel, handler:nil))
        self.present(alert, animated: true, completion: nil)

    }
    
    @IBAction func EditBu(_ sender: UIButton) {
        guard let name = UserNameText.text , !name.isEmpty else {
            let message = "يجب عليك إدخال حقل الإسم"
            self.AlertAction(message: message)
                       return}
        guard let mobile = MobilteText.text , !mobile.isEmpty else {
            let message = "يجب عليك إدخال حقل الموبايل"
            self.AlertAction(message: message)
            return}
        guard let email = EmailText.text , !email.isEmpty else {
            let message = "يجب عليك إدخال حقل الإيميل"
            self.AlertAction(message: message)
            return}
        guard let password = PasswordText.text , !password.isEmpty else {
            
            let message = "يجب عليك إدخال حقل الرقم السرى"
            self.AlertAction(message: message)
            return}
        if let api_token = ApiToken.getApiToken() {
            APIMethods.EditUserData(api_token: api_token, name: UserNameText.text!, mobile: MobilteText.text!, email: EmailText.text!, password: PasswordText.text!)
        }
    }
    
    
}
