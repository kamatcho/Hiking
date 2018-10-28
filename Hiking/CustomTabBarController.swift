//
//  CustomTabBarController.swift
//  Hiking
//
//  Created by MOHAMED on 3/22/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

   // @IBOutlet weak var financialTabBar: UITabBar!
    
    @IBOutlet weak var MyTabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // I've added this line to viewDidLoad
      //  UIApplication.shared.statusBarFrame.size.height
    MyTabBar.frame = CGRect(x: 0, y:  MyTabBar.frame.size.height + 80 , width: MyTabBar.frame.size.width, height: MyTabBar.frame.size.height)
      //  let itemSize = CGSize(width: tabBar.frame.width / 5, height: tabBar.frame.height)
        self.MyTabBar.barTintColor = UIColor.black
        
        self.MyTabBar.tintColor = UIColor.white
            self.MyTabBar.backgroundColor = UIColor.white
        // set the positioning to fill the whole width of the tabBar
        self.tabBar.itemPositioning = .fill
        
        ///self.tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.8)
        
        // set the tabBar title font
        for item in self.tabBar.items! {
            item.setTitleTextAttributes([NSFontAttributeName : UIFont.init(name: "GE SS Two", size: 11)!], for: .normal)
        }
    }
    
        
    }


