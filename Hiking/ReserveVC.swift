//
//  ReserveVC.swift
//  Hiking
//
//  Created by MOHAMED on 4/8/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit

class ReserveVC: UIViewController , UITableViewDelegate,UITableViewDataSource {
    
    
    
    var Reserve = [ReseveModel]()
    lazy var refresher : UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handelRefresh), for: .valueChanged)
        return refresher
    }()
    
    var current_page :Int = 1
    var last_page : Int = 1
    var isLoading : Bool = false
    
    
    @IBOutlet weak var tableView: UITableView!
    var MenuIsOpen = false
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refresher)
        
        handelRefresh()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let api_toke = ApiToken.getApiToken() {}else{
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
    @IBAction func MenuBu(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuVC
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    @objc private func handelRefresh() {
        
        self.refresher.endRefreshing()
        
        guard !isLoading else {return}
        
        isLoading = true
        if let api_token = ApiToken.getApiToken() {
            APIMethods.UserResrvations(api_token : api_token){ (error : Error?, reservs :[ReseveModel]?, last_page : Int) in
                
                self.isLoading = false
                
                if let reservs = reservs {
                    
                    self.Reserve = reservs
                    
                    self.tableView.reloadData()
                    
                    self.current_page = 1
                    
                    self.last_page = last_page
                    
                }
                
            }
            
            
        }else {
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
    
    func loadMore ()  {
        
        guard !isLoading else {return}
        
        guard current_page < last_page else {return}
        
        isLoading = true
        if let api_token = ApiToken.getApiToken() {
            APIMethods.UserResrvations(api_token  : api_token , page: current_page+1) { (error : Error?, reservs :[ReseveModel]?, last_page : Int) in
                
                self.isLoading = false
                
                if let reservs = reservs {
                    
                    self.Reserve.append(contentsOf: reservs)
                    
                    self.tableView.reloadData()
                    self.current_page += 1
                    self.last_page = last_page
                    
                }
                
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
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Reserve.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReserveCell") as! ReserveCell
        
        let reserve = Reserve[indexPath.row]
        cell.ConfigureCell(reserve: reserve)
        return cell
    }
    
    
    
}
