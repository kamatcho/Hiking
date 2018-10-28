//
//  SearchResultCell.swift
//  Hiking
//
//  Created by MOHAMED on 4/1/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import Kingfisher
class SearchResultCell: UITableViewCell {

    @IBOutlet weak var BuildPrice: UILabel!
    @IBOutlet weak var BuildName: UILabel!
    @IBOutlet weak var BuildImage: UIImageView!
    @IBOutlet weak var BuildCity: UILabel!
    @IBOutlet weak var ReserveButton: UIButton!
    
    func ConfigureCell(build : BuildModel){
        BuildName.text = build.name
        BuildPrice.text = build.price
        BuildCity.text = build.city + " /" + build.area
        let url = URL(string: build.image)!
        ReserveButton.tag = build.id
        print(url)
        BuildImage.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.flipFromLeft(0.5))], progressBlock: nil, completionHandler: nil)
    }
    
}
