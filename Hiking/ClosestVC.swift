//
//  ClosestVC.swift
//  Hiking
//
//  Created by MOHAMED on 3/27/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class ClosestVC: UIViewController , UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate {
    
    
    var locationmanager = CLLocationManager()
    var userLocation : CLLocation!
    
    @IBOutlet weak var ConstraintFromRight: NSLayoutConstraint!
    
    //  @IBOutlet weak var ConstraintFromRight: NSLayoutConstraint!
    var Build = [BuildModel]()
    lazy var refresher : UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handelRefresh), for: .valueChanged)
        return refresher
    }()
    
    var current_page :Int = 1
    var last_page : Int = 1
    var isLoading : Bool = false
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    @IBOutlet weak var tableView: UITableView!
    var MenuIsOpen = false
    override func viewDidLoad() {
        
        super.viewDidLoad()
        locManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locManager.location
            print(ClosestBuildingUrl)
            print(currentLocation.coordinate.longitude)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refresher)
        
        handelRefresh()
        
        
    }
    @IBAction func SearchIcinBu(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchScreen") as! SearchVC
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func MenuBu(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuVC
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @objc private func handelRefresh() {
        
        self.refresher.endRefreshing()
        
        guard !isLoading else {return}
        
        isLoading = true
        let lat = currentLocation.coordinate.latitude
        let lan = currentLocation.coordinate.longitude
        let latlng = "\(lat),\(lan)"
        APIMethods.ClosestBuilding(latlng : latlng){ (error : Error?, builds :[BuildModel]?, last_page : Int) in
            
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
        let lat = currentLocation.coordinate.latitude
        let lan = currentLocation.coordinate.longitude
        let latlng = "\(lat),\(lan)"
        
        APIMethods.ClosestBuilding(latlng : latlng,page: current_page+1) { (error : Error?, builds :[BuildModel]?, last_page : Int) in
            
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClosestCelll") as! ClosestCell
        
        let build = Build[indexPath.row]
        cell.ClosestCell(build: build)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ClosesetSingleBuild", sender: Build[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dist = segue.destination as? UINavigationController {
            let tabevc = dist.viewControllers.first as! SingleBuildVC
            if let Item = sender as? BuildModel {
                tabevc.SingleItem = Item
            }
            
        }
        
    }
    
    
}
