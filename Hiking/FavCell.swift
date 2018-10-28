//
//  FavCell.swift
//  Hiking
//
//  Created by MOHAMED on 4/7/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import Kingfisher
class FavCell: UITableViewCell {
    
    @IBOutlet weak var FavImage: UIImageView!
    @IBOutlet weak var FavLocation: UILabel!
    
    @IBOutlet weak var FavPrice: UILabel!
    @IBOutlet weak var FavName: UILabel!
    func ConfigureCell(build : BuildModel){
        FavName.text = build.name
        FavPrice.text = build.price
        FavLocation.text = build.city + " " + build.area
        let url = URL(string: build.image)!
        print(url)
        FavImage.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.flipFromLeft(0.5))], progressBlock: nil, completionHandler: nil)
        
    }
}


