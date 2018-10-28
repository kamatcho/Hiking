//
//  SmsVC.swift
//  Hiking
//
//  Created by MOHAMED on 3/24/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit

class SmsVC: UIViewController {
    
    @IBOutlet weak var ConstraintFromRight: NSLayoutConstraint!
    @IBOutlet weak var SmsText: UITextField!
    var MenuIsOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func AlertAction(message : String){
        let title  = "خطأ"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "موافق", style: UIAlertActionStyle.cancel, handler:nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func SmsActiveBu(_ sender: Any) {
        guard let sms = SmsText.text ,!sms.isEmpty else {
            
            let message = "يجب عليك إدخال رمز التفعيل"
            self.AlertAction(message: message)
            return}
        APIMethods.SmsActivation(Code: Int( SmsText.text!)!)
    }
    @IBAction func MenuBu(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuVC
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
}
