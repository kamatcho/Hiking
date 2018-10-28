//
//  ReserveBuildingVC.swift
//  Hiking
//
//  Created by MOHAMED on 4/16/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import Foundation
class ReserveBuildingVC: UIViewController {
    var Build_id : Int?
    var day : String?
    
    @IBOutlet weak var NationalityText: UILabel!
    @IBOutlet weak var DateText: UILabel!
    @IBOutlet weak var DayText: UILabel!
    @IBOutlet weak var NameText: UITextField!
    @IBOutlet weak var IdentityText: UITextField!
    @IBOutlet weak var MobileText: UITextField!
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var NationBuText: UIButton!
    
    @IBOutlet weak var CommentText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MuBuild",Build_id)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func MenuBu(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuVC
        self.present(vc, animated: true, completion: nil)
    }
    
    var birthdate : Date?
    
    @IBAction func DayBu(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        var available_time = ["الخميس", "السبت" , "الجمعة", "وسط الأسبوع"];
        for data in available_time {
            alert.addAction(UIAlertAction(title: data, style: UIAlertActionStyle.default, handler:{ action ->Void in
                let buttonTitle = action.title
                self.DayText.text = buttonTitle
            }))
            
            
        }
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "إلغاء", style: UIAlertActionStyle.cancel, handler:nil))
        
        alert.popoverPresentationController?.sourceRect = (sender.bounds)
        alert.popoverPresentationController?.sourceView = sender
        self.navigationController?.pushViewController(alert, animated: true)
    }
    
    @IBAction func Date(_ sender: UIButton) {
        self.showDatesPickerViewController { date in
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.dateFormat = "YYY-MM-dd"
            self.birthdate = date
            self.DateText.text = formatter.string(from: date)
            sender.setTitle(date.readableDate, for: .normal)
        }
        
    }
    
    @IBAction func NationalityBu(_ sender: UIButton) {
        self.view.showActivityIndicator()
        let presenter = APIPlacesPresenter()
        presenter.showPlacesIn(vc: self, sender: sender) { (place) in
            self.NationalityText.text = place.title
            sender.setTitle(String(place.id), for: .normal)
            self.view.hideActivityIndicator()
            
            
            
        }
    }
    func AlertAction(message : String){
        let title  = "خطأ"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "موافق", style: UIAlertActionStyle.cancel, handler:nil))
        self.present(alert, animated: true, completion: nil)
        
    }

    @IBAction func PayBu(_ sender: UIButton) {
        
        switch DateText.text! {
        case "الخميس":
            self.day = "thursday"
        case "السبت" :
            self.day = "saturday"
        case "الجمعة" :
            self.day = "friday"
        case "وسط الأسبوع" :
            self.day = "middle_week"
            
        default:
            print("No Time")
        }
        guard let nametxt = self.NameText.text , !nametxt.isEmpty else {
            let message = "أنت تحتاج إلى إدخال حقل الإسم"
            self.AlertAction(message: message)
            return
        }
        
        guard let commenttxt = self.CommentText.text , !commenttxt.isEmpty else {
            
            
            self.CommentText.text = "لايوجد تعليقات"
            return
        }
        guard let datetxt = self.DateText.text , !datetxt.isEmpty else {
            let message = "يجب أن تختار تاريخ الحجز"
            self.AlertAction(message: message)
            return
        }
        guard let emailtxt = self.EmailText.text , !emailtxt.isEmpty else {
            let message = "يجب إدخال البريد الإلكترونى"
            self.AlertAction(message: message)
            return
        }
        guard let mobiletxt = self.MobileText.text , !mobiletxt.isEmpty else {
            let message = "يجب إدخال رقم الجوال"
            self.AlertAction(message: message)
            return
        }
        guard let nationaltxt = self.NationBuText.titleLabel?.text , !nationaltxt.isEmpty else {
            let message = "يجب أن تختار الجنسية"
            self.AlertAction(message: message)
            return
        }
        guard let identtxt = self.IdentityText.text , !identtxt.isEmpty else {
            let message = "يجب رقم الهوية"
            self.AlertAction(message: message)
            return
        }
        if let api_token = ApiToken.getApiToken(){
            let StringBuildId = String(describing: Build_id!)
            let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ").inverted)
            let namestring = NameText.text?.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
            let commentstring = CommentText.text?.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
            let mystring = "http://217.182.113.163/~haking/api/payment?build_id=\(StringBuildId)&date=\(self.DateText.text!)&comment_by_user=\(commentstring!)&email=\(self.EmailText.text!)&mobile=\(MobileText.text!)&nationality=\(NationBuText.titleLabel!.text!)&card_id=\(IdentityText.text!)&name=\(namestring!)&date_reserv=\(self.DateText.text!)&day=\(self.day)&api_token=\(api_token)"
            
            print(mystring)
            if let url  = URL(string: mystring){
                
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    //If you want handle the completion block than
                    UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                        print("Open url : \(success)")
                    })
                    
                }
                
            }else {
                let message = "برجاء التأكد من إدخال تاريخ ووقت الحجز"
                self.AlertAction(message: message)
            }
        }else {
            let message = "أنت تحتاج إلى تسجيل الدخول أولا"
            self.AlertAction(message: message)
            self.LoginScreen()
        }
     
    }
    func LoginScreen(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginScreen")
        
        self.present(vc!, animated: true, completion: nil)
    }
   
    
}
