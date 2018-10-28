//
//  SectionModel.swift
//  Hiking
//
//  Created by MOHAMED on 4/1/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


struct SectionModel {
    var id: Int!
    var title: String!
    
    
    
    init(section : [String:JSON]) {
        if let ID = section["id"]?.int{
            self.id = ID
        }
        if let title = section["name"]?.string {
            self.title = title
        }
        
    }
    
    
    
    static func showSectionIn(id : Int , vc: UIViewController, sender: UIButton, completion: @escaping (_ section: SectionModel) -> ()) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let SectionNav = storyboard.instantiateViewController(withIdentifier: "SectionViewController") as! UINavigationController
        let SectionTVC = SectionNav.viewControllers.first! as! SectionViewController
        SectionTVC.completion = completion
        SectionTVC.city_id = id
        
        vc.present(SectionNav, animated: true, completion: nil)
    }
    
}

class APISectionPresenter: NSObject, UIPopoverPresentationControllerDelegate {
    
    func showSectionIn(id : Int , vc: UIViewController, sender: UIButton, completion: @escaping (_ section: SectionModel) -> ()) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let SectionNav = storyboard.instantiateViewController(withIdentifier: "SectionViewController") as! UINavigationController
        let SectionTVC = SectionNav.viewControllers.first! as! SectionViewController
        SectionTVC.completion = completion
        SectionTVC.city_id = id
        
        SectionNav.modalPresentationStyle = .popover
        SectionNav.preferredContentSize = CGSize(width: vc.view.frame.width - 40, height: 300)
        
        let popover = SectionNav.popoverPresentationController!
        popover.delegate = self
        popover.sourceView = sender
        popover.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.midY , width: 0, height: 0)
        popover.permittedArrowDirections = [.up, .down]
        
        vc.present(SectionNav, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
