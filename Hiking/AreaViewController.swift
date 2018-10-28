//
//  AreaViewController.swift
//  Hiking
//
//  Created by MOHAMED on 3/31/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit

class AreaViewController: UITableViewController {
    
    var completion: ((_ place: AreaModel) -> ())!
    var country_id : Int = 1
    var Areas = [AreaModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.getAreas), for: .valueChanged)
        self.getAreas()
    }
    
    func getAreas() {
        if (self.refreshControl?.isRefreshing)! {
            self.refreshControl?.endRefreshing()
        }
        
        self.Areas.removeAll(keepingCapacity: true)
        
        self.addText(" ")
        self.view.showActivityIndicator()
        APIMethods.getAllAreas(id:country_id) { (error,areas) in
            self.Areas =  areas!
            
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
        return self.Areas.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "AreaCell", for: indexPath)
        cell.textLabel?.text = self.Areas[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.completion(self.Areas[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismiss(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

}
