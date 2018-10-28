//
//  SearchResultVC.swift
//  Hiking
//
//  Created by MOHAMED on 4/1/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit

class SearchResultVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var city_name : String?
    @IBOutlet weak var tableView: UITableView!
    var Build = [BuildModel]()
    lazy var refresher : UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handelRefresh), for: .valueChanged)
        return refresher
    }()
    
    var current_page :Int = 1
    var last_page : Int = 1
    var isLoading : Bool = false
    
    
    var MenuIsOpen = false
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refresher)
        
        handelRefresh()
        
        
    }
    @IBAction func MenuBu(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuVC
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    @objc private func handelRefresh() {
        
        self.refresher.endRefreshing()
        
        guard !isLoading else {return}
        
        isLoading = true
        
        APIMethods.BuildingSearch(city : city_name!){ (error : Error?, builds :[BuildModel]?, last_page : Int) in
            
            self.isLoading = false
            
            if let builds = builds {
                
                self.Build = builds
                
                self.tableView.reloadData()
                
                self.current_page = 1
                
                self.last_page = last_page
                
            }
            
        }
        
        
    }
    
    
    func loadMore ()  {
        
        guard !isLoading else {return}
        
        guard current_page < last_page else {return}
        
        isLoading = true
        
        APIMethods.BuildingSearch(city: city_name!, page: current_page+1) { (error : Error?, builds :[BuildModel]?, last_page : Int) in
            
            self.isLoading = false
            
            if let builds = builds {
                
                self.Build.append(contentsOf: builds)
                
                self.tableView.reloadData()
                
                
                self.current_page += 1
                
                self.last_page = last_page
                
            }
            
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Build.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell") as! SearchResultCell
        
        let build = Build[indexPath.row]
        cell.ConfigureCell(build: build)
        cell.ReserveButton.addTarget(self, action: #selector(SearchResultVC.ReserveBuild), for: UIControlEvents.touchUpInside)
        return cell
    }
    @IBAction func ReserveBuild(_ sender: UIButton) {
        
      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SearchSingleBuild", sender: Build[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSingleBuild"{
            if let dist = segue.destination as? UINavigationController {
                let tabevc = dist.viewControllers.first as! SingleBuildVC
                if let Item = sender as? BuildModel {
                    tabevc.SingleItem = Item
                }
                
            }
        } else if segue.identifier == "SearchReserveBuild"{
            if ((sender as? UIButton) != nil) {
                if let dist = segue.destination as? ReserveBuildingVC {
                    if  let item = sender  {
                        dist.Build_id = (item as! UIButton).tag
                    }
                    
                    
                }
                
            }
        }
    }
    
    
}
