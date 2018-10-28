//
//  RegisterVC.swift
//  Hiking
//
//  Created by MOHAMED on 3/19/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class RegisterVC: UIViewController {
    
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var rePasswordText: UITextField!
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var UserNameText: UITextField!
    @IBOutlet weak var ConstraintFromRight: NSLayoutConstraint!
    @IBOutlet weak var ReEmail: UITextField!
    @IBOutlet weak var PhoneText: UITextField!
    var MenuIsOpen = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func MenuBu(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuVC
        self.present(vc, animated: true, completion: nil)        
    }
    func AlertAction(message : String){
        let title  = "خطأ"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "موافق", style: UIAlertActionStyle.cancel, handler:nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func RegisterBu(_ sender: Any) {
        // Check Inputs Values
        guard let password = self.PasswordText.text , !password.isEmpty  else {
            
            let message = "يجب عليك إدخال حقل كلمة المرور"
            self.AlertAction(message: message)
            return}
        guard let username = UserNameText.text , !username.isEmpty else {
            
            let message = "يجب عليك إدخال حقل الإسم"
            self.AlertAction(message: message)
            return}
        guard let email = EmailText.text , !email.isEmpty else {
            let message = "يجب عليك إدخال حقل الإيميل"
            self.AlertAction(message: message)
            return}
        guard let phone = PhoneText.text , !phone.isEmpty else {
            
            let message = "يجب عليك إدخال حقل رقم الجوال"
            self.AlertAction(message: message)
            return}
        guard let repassword = rePasswordText.text , !repassword.isEmpty else {
            let message = "يجب عليك إعادة كتابة كلمة المرور"
            self.AlertAction(message: message)
            return}
        guard let reemail = ReEmail.text , !reemail.isEmpty else {
            let message = "يجب عليك إعادة كتابة البريد الإلكترونى"
            self.AlertAction(message: message)
            return}
        
        guard password == repassword else {
            let message = "كلمة المرور غير متطابقة"
            self.AlertAction(message: message)
            return}
        guard email == reemail else {
            let message = "البريد الإلكترونى غير متطابق"
            self.AlertAction(message: message)
            
            return}
        self.RegisterButton.showActivityIndicator()
        self.RegisterButton.isUserInteractionEnabled  = false
        
        APIMethods.Register(username: self.UserNameText.text!, password: self.PasswordText.text!, email: self.EmailText.text!, mobile: self.PhoneText.text!,password_confirmation : self.rePasswordText.text!){(status,message,activationtype) in
            
            if activationtype == "sms" {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SmsActivation")
                self.present(vc!, animated: true, completion: nil)
            }else if activationtype == "mail" {
                let title:String = "إنشاء حساب"
                let message = "تم إرسال رسالة التفعيل إلى بريدك الإلكترونى"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "موافق", style: UIAlertActionStyle.cancel, handler:nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        self.RegisterButton.isUserInteractionEnabled  = true
        self.view.hideActivityIndicator()
    }
    
}
