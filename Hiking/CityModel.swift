//
//  CityModel.swift
//  Hiking
//
//  Created by MOHAMED on 3/31/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//


import Foundation
import UIKit
import SwiftyJSON


struct CityModel {
    var id: Int!
    var title: String!
    
    
    
    init(city : [String:JSON]) {
        if let ID = city["id"]?.int{
            self.id = ID
        }
        if let title = city["name"]?.string {
            self.title = title
        }
        
    }
    
    
    
    static func showCityIn(id : Int , vc: UIViewController, sender: UIButton, completion: @escaping (_ city: CityModel) -> ()) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CityNav = storyboard.instantiateViewController(withIdentifier: "CityViewController") as! UINavigationController
        let CityTVC = CityNav.viewControllers.first! as! CityViewController
        CityTVC.completion = completion
        CityTVC.area_id = id
        
        vc.present(CityNav, animated: true, completion: nil)
    }
    
}

class APICityPresenter: NSObject, UIPopoverPresentationControllerDelegate {
    
    func showCityIn(id : Int , vc: UIViewController, sender: UIButton, completion: @escaping (_ city: CityModel) -> ()) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CityNav = storyboard.instantiateViewController(withIdentifier: "CityViewController") as! UINavigationController
        let CityTVC = CityNav.viewControllers.first! as! CityViewController
        CityTVC.completion = completion
        CityTVC.area_id = id
        
        CityNav.modalPresentationStyle = .popover
        CityNav.preferredContentSize = CGSize(width: vc.view.frame.width - 40, height: 300)
        
        let popover = CityNav.popoverPresentationController!
        popover.delegate = self
        popover.sourceView = sender
        popover.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.midY , width: 0, height: 0)
        popover.permittedArrowDirections = [.up, .down]
        
        vc.present(CityNav, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
