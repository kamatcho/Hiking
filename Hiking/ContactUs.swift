//
//  ContactUs.swift
//  Hiking
//
//  Created by MOHAMED on 3/30/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit

class ContactUs: UIViewController {
    

    @IBOutlet weak var MessageText: UITextView!
    @IBOutlet weak var SubjectText: UITextField!
    @IBOutlet weak var PhoneText: UITextField!
    @IBOutlet weak var MailText: UITextField!
    @IBOutlet weak var NameText: UITextField!
    var MenuIsOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    func AlertAction(message : String){
        let title  = "خطأ"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "موافق", style: UIAlertActionStyle.cancel, handler:nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func SendBu(_ sender: UIButton) {
        
        guard let Name = self.NameText.text , !Name.isEmpty else {
            
            let message = "يجب عليك إدخال حقل الإسم"
            self.AlertAction(message: message)
            return}
        guard let Email = self.MailText.text , !Email.isEmpty else {
            
            let message = "يجب عليك إدخال البريد الإلكترونى"
            self.AlertAction(message: message)
            return}
        guard let Title = self.SubjectText.text , !Title.isEmpty else {
            
            
            let message = "يجب عليك إدخال عنوان الرسالة"
            self.AlertAction(message: message)
            return}
        guard let Details = self.MessageText.text , !Details.isEmpty else {
            
            let message = "يجب عليك إدخال نص الرسالة"
            self.AlertAction(message: message)
            return}
        
        
        APIMethods.ContactUs(name: NameText.text!, mail: MailText.text!, title: SubjectText.text!, details: MessageText.text!)
        self.NameText.text = ""
        self.MailText.text = ""
        self.SubjectText.text = ""
        self.MessageText.text = ""
        self.PhoneText.text = ""
        
        
    }
    @IBAction func MenuBuAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuVC
        self.present(vc, animated: true, completion: nil)
        
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
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
