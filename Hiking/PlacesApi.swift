//
//  PlacesApi.swift
//  Hiking
//
//  Created by MOHAMED on 3/30/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class PlacesApi {
    class APICountryPresenter: NSObject, UIPopoverPresentationControllerDelegate {
        
        func showPlaces(vc: UIViewController, sender: UIButton, completion: @escaping (_ place: PlacesModel) -> ()) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let countriesNav = storyboard.instantiateViewController(withIdentifier: "PlaceViewController") as! UINavigationController
            let countriesTVC = countriesNav.viewControllers.first! as! PlaceViewController
          
            
            countriesNav.modalPresentationStyle = .popover
            countriesNav.preferredContentSize = CGSize(width: vc.view.frame.width - 40, height: 300)
            
            let popover = countriesNav.popoverPresentationController!
            popover.delegate = self
            popover.sourceView = sender
            popover.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.midY , width: 0, height: 0)
            popover.permittedArrowDirections = [.up, .down]
            
            vc.present(countriesNav, animated: true, completion: nil)
        }
        
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
        
    }
}
