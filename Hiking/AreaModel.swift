//
//  AreaModel.swift
//  Hiking
//
//  Created by MOHAMED on 3/31/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


struct AreaModel {
    var id: Int!
    var title: String!
    
    
    
    init(Area : [String:JSON]) {
        if let ID = Area["id"]?.int{
            self.id = ID
        }
        if let title = Area["name"]?.string {
            self.title = title
        }
        
    }
    
    
    
    static func showAreaIn(id : Int , vc: UIViewController, sender: UIButton, completion: @escaping (_ area: AreaModel) -> ()) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let AreaNav = storyboard.instantiateViewController(withIdentifier: "AreaViewController") as! UINavigationController
        let AreaTVC = AreaNav.viewControllers.first! as! AreaViewController
        AreaTVC.completion = completion
        AreaTVC.country_id = id
        
        vc.present(AreaNav, animated: true, completion: nil)
    }
    
}

class APIAreaPresenter: NSObject, UIPopoverPresentationControllerDelegate {
    
    func showAreaIn(id : Int , vc: UIViewController, sender: UIButton, completion: @escaping (_ place: AreaModel) -> ()) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let AreaNav = storyboard.instantiateViewController(withIdentifier: "AreaViewController") as! UINavigationController
        let AreaTVC = AreaNav.viewControllers.first! as! AreaViewController
        AreaTVC.completion = completion
        AreaTVC.country_id = id

        AreaNav.modalPresentationStyle = .popover
        AreaNav.preferredContentSize = CGSize(width: vc.view.frame.width - 40, height: 300)
        
        let popover = AreaNav.popoverPresentationController!
        popover.delegate = self
        popover.sourceView = sender
        popover.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.midY , width: 0, height: 0)
        popover.permittedArrowDirections = [.up, .down]
        
        vc.present(AreaNav, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
