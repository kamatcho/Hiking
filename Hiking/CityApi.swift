//
//  CityApi.swift
//  Hiking
//
//  Created by MOHAMED on 3/31/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//
import Foundation
import UIKit
import SwiftyJSON
class CityApi {
    class APICityPresenter: NSObject, UIPopoverPresentationControllerDelegate {
        
        func showPlaces(vc: UIViewController, sender: UIButton, completion: @escaping (_ place: CityModel) -> ()) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let cityNav = storyboard.instantiateViewController(withIdentifier: "CityViewController") as! UINavigationController
            let CityTVC = cityNav.viewControllers.first! as! CityViewController
            
            
            cityNav.modalPresentationStyle = .popover
            cityNav.preferredContentSize = CGSize(width: vc.view.frame.width - 40, height: 300)
            
            let popover = cityNav.popoverPresentationController!
            popover.delegate = self
            popover.sourceView = sender
            popover.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.midY , width: 0, height: 0)
            popover.permittedArrowDirections = [.up, .down]
            
            vc.present(cityNav, animated: true, completion: nil)
        }
        
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
        
    }
}
