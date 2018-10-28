//
//  NewestCell.swift
//  Hiking
//
//  Created by MOHAMED on 3/29/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import Kingfisher
class NewestCell: UITableViewCell {

   
   // @IBOutlet weak var BgImage: UIImageView!
    
    // Newest
    @IBOutlet weak var NewestImage: UIImageView!
    @IBOutlet weak var NewestName: UILabel!
    @IBOutlet weak var NewestPrice: UILabel!
    var id : Int!
    @IBOutlet weak var NewestLocation: UILabel!
    func ConfigureCell(build : BuildModel){
        NewestName.text = build.name
        NewestPrice.text = build.price
        id = build.id
        print(id)
        NewestLocation.text = build.city + " " + build.area
        let url = URL(string: build.image)!
        print(url)
        NewestImage.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.flipFromLeft(0.5))], progressBlock: nil, completionHandler: nil)
    }
    
    
}
