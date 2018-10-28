//
//  SectionApi.swift
//  Hiking
//
//  Created by MOHAMED on 4/1/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class SectionApi {
    class APISectionPresenter: NSObject, UIPopoverPresentationControllerDelegate {
        
        func showPlaces(vc: UIViewController, sender: UIButton, completion: @escaping (_ place: SectionModel) -> ()) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let sectionNav = storyboard.instantiateViewController(withIdentifier: "SectionViewController") as! UINavigationController
            let SectionTVC = sectionNav.viewControllers.first! as! SectionViewController
            
            
            sectionNav.modalPresentationStyle = .popover
            sectionNav.preferredContentSize = CGSize(width: vc.view.frame.width - 40, height: 300)
            
            let popover = sectionNav.popoverPresentationController!
            popover.delegate = self
            popover.sourceView = sender
            popover.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.midY , width: 0, height: 0)
            popover.permittedArrowDirections = [.up, .down]
            
            vc.present(sectionNav, animated: true, completion: nil)
        }
        
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
        
    }
}
