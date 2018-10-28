//
//  SectionViewController.swift
//  Hiking
//
//  Created by MOHAMED on 4/1/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit

class SectionViewController: UITableViewController {

    
    var completion: ((_ place: SectionModel) -> ())!
    var city_id : Int = 1
    var Sections = [SectionModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.getSections), for: .valueChanged)
        self.getSections()
    }
    
    func getSections() {
        if (self.refreshControl?.isRefreshing)! {
            self.refreshControl?.endRefreshing()
        }
        
        self.Sections.removeAll(keepingCapacity: true)
        
        self.addText(" ")
        self.view.showActivityIndicator()
        APIMethods.getAllSections(id:city_id) { (error,sections) in
            self.Sections =  sections!
            
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
        return self.Sections.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionCell", for: indexPath)
        cell.textLabel?.text = self.Sections[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.completion(self.Sections[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismiss(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
