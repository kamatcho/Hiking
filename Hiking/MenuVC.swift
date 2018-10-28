//
//  MenuVC.swift
//  Hiking
//
//  Created by MOHAMED on 4/8/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    @IBOutlet var MainView: UIView!
    
    @IBOutlet weak var MyFavBu: UIButton!
    
    @IBOutlet weak var LogoutText: UILabel!
    @IBOutlet weak var MyFavText: UILabel!
    @IBOutlet weak var MyreserveText: UILabel!
    @IBOutlet weak var MyAccountText: UILabel!
    @IBOutlet weak var LogoutBu: UIButton!
    @IBOutlet weak var MyReserveBu: UIButton!
    @IBOutlet weak var MyAccountBu: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let api_token = ApiToken.getApiToken() {
            
        }else{
            self.LogoutText.isHidden = true
            self.MyFavText.isHidden = true
            self.LogoutBu.isHidden = true
            self.MyFavBu.isHidden = true
            self.MyAccountText.text = "تسجيل الدخول"
            self.MyreserveText.text = "إنشاء حساب"

        }
        
        var Tap = UITapGestureRecognizer(target: self, action: "CloseWindow")
        // Do any additional setup after loading the view.
        self.MainView.addGestureRecognizer(Tap)
    }
    func CloseWindow() {
        self.dismiss(animated: true, completion: nil)
    }
   
    @IBAction func ShareAppBu(_ sender: UIButton) {
        let activityVc = UIActivityViewController(activityItems: [SharingAppUrl], applicationActivities: nil)
        activityVc.popoverPresentationController?.sourceView = self.view
        self.present(activityVc, animated: true, completion: nil)
    }


    @IBAction func LogoutBu(_ sender: UIButton) {
        if let api_token = ApiToken.getApiToken() {
            UserDefaults.standard.removeObject(forKey: "api_token")
            self.LoginScreen()

        }else{
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
    
    @IBAction func MyAccountAction(_ sender: UIButton) {
        if let api_token = ApiToken.getApiToken(){
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyAccountVC")
            
            self.present(vc!, animated: true, completion: nil)
        }else {
            self.LoginScreen()
        }
    }

    @IBAction func MyReserveAction(_ sender: UIButton) {
        
        
        if let api_token = ApiToken.getApiToken(){
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyReserveVC")
            self.present(vc!, animated: true, completion: nil)

            
        }else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC")
            self.present(vc!, animated: true, completion: nil)

        }

    }
}
