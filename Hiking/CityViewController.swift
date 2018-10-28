//
//  CityViewController.swift
//  Hiking
//
//  Created by MOHAMED on 3/31/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit

class CityViewController: UITableViewController {
    
    var completion: ((_ place: CityModel) -> ())!
    var area_id : Int = 1
    var Cities = [CityModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.getCities), for: .valueChanged)
        self.getCities()
    }
    
    func getCities() {
        if (self.refreshControl?.isRefreshing)! {
            self.refreshControl?.endRefreshing()
        }
        
        self.Cities.removeAll(keepingCapacity: true)
        
        self.addText(" ")
        self.view.showActivityIndicator()
        APIMethods.getAllCities(id:area_id) { (error,cities) in
            self.Cities =  cities!
            
            self.tableView.reloadData()
            self.view.hideActivityIndicator()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Cities.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        cell.textLabel?.text = self.Cities[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.completion(self.Cities[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismiss(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
