//
//  RestCell.swift
//  Hiking
//
//  Created by MOHAMED on 3/21/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
//import Kingfisher
import Kingfisher
class RestCell: UITableViewCell {
// Special
    @IBOutlet weak var BuidImage: UIImageView!
    @IBOutlet weak var LocationText: UILabel!
    @IBOutlet weak var Nametext: UILabel!
    @IBOutlet weak var PriceText: UILabel!
    @IBOutlet weak var BgImage: UIImageView!
    
    // Closest
   
    func ConfigureCell(build : BuildModel){
        Nametext.text = build.name
        PriceText.text = build.price
        LocationText.text = build.city + " " + build.area
      let url = URL(string: build.image)!
        print(url)
        BuidImage.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.flipFromLeft(0.5))], progressBlock: nil, completionHandler: nil)
    }
    
       
}
