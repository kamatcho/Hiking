//
//  ClosestCell.swift
//  Hiking
//
//  Created by MOHAMED on 3/27/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import Kingfisher
class ClosestCell: UITableViewCell {

    @IBOutlet weak var ClosestName: UILabel!
    @IBOutlet weak var ClosestPrice: UILabel!
    
    @IBOutlet weak var ClosestImage: UIImageView!
    @IBOutlet weak var ClosestLocation: UILabel!
    func ClosestCell(build : BuildModel)  {
        ClosestName.text = build.name
        ClosestPrice.text = build.price
        ClosestLocation.text = build.city + " " + build.area
        let url = URL(string: build.image)!
        print(url)
        ClosestImage.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.flipFromLeft(0.5))], progressBlock: nil, completionHandler: nil)
    }
    

}
