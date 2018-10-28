//
//  PlacesModel.swift
//  Hiking
//
//  Created by MOHAMED on 3/31/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


struct PlacesModel {
    var id: Int!
    var title: String!

    
 
    init(Places : [String:JSON]) {
        if let ID = Places["id"]?.int{
            self.id = ID
        }
        if let title = Places["name"]?.string {
            self.title = title
        }
        
    }
    
   
    
    static func showPlacesIn(vc: UIViewController, sender: UIButton, completion: @escaping (_ place: PlacesModel) -> ()) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let countriesNav = storyboard.instantiateViewController(withIdentifier: "PlaceViewController") as! UINavigationController
        let PlacesTVC = countriesNav.viewControllers.first! as! PlaceViewController
        PlacesTVC.completion = completion
        
        vc.present(countriesNav, animated: true, completion: nil)
    }
    
}

class APIPlacesPresenter: NSObject, UIPopoverPresentationControllerDelegate {
    
    func showPlacesIn(vc: UIViewController, sender: UIButton, completion: @escaping (_ place: PlacesModel) -> ()) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let PlacesNav = storyboard.instantiateViewController(withIdentifier: "PlaceViewController") as! UINavigationController
        let PlacesTVC = PlacesNav.viewControllers.first! as! PlaceViewController
        PlacesTVC.completion = completion
        
        PlacesNav.modalPresentationStyle = .popover
        PlacesNav.preferredContentSize = CGSize(width: vc.view.frame.width - 40, height: 300)
        
        let popover = PlacesNav.popoverPresentationController!
        popover.delegate = self
        popover.sourceView = sender
        popover.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.midY , width: 0, height: 0)
        popover.permittedArrowDirections = [.up, .down]
        
        vc.present(PlacesNav, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
