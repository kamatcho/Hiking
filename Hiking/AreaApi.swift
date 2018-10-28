//
//  AreaApi.swift
//  Hiking
//
//  Created by MOHAMED on 3/31/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//


import Foundation
import UIKit
import SwiftyJSON
class AreaApi {
    class APIAreaPresenter: NSObject, UIPopoverPresentationControllerDelegate {
        
        func showPlaces(vc: UIViewController, sender: UIButton, completion: @escaping (_ place: AreaModel) -> ()) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let areaNav = storyboard.instantiateViewController(withIdentifier: "AreaViewController") as! UINavigationController
            let AreasTCV = areaNav.viewControllers.first! as! AreaViewController
            
            
            areaNav.modalPresentationStyle = .popover
            areaNav.preferredContentSize = CGSize(width: vc.view.frame.width - 40, height: 300)
            
            let popover = areaNav.popoverPresentationController!
            popover.delegate = self
            popover.sourceView = sender
            popover.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.midY , width: 0, height: 0)
            popover.permittedArrowDirections = [.up, .down]
            
            vc.present(areaNav, animated: true, completion: nil)
        }
        
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
        
    }
}
