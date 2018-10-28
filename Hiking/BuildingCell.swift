//
//  BuildingCell.swift
//  Hiking
//
//  Created by MOHAMED on 4/5/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import Kingfisher
class BuildingCell: UICollectionViewCell {

    @IBOutlet weak var BuildFacility: UIImageView!
    
    @IBOutlet weak var FacilityText: UILabel!
    
    func ConfigureCell (build : BuildFacilityModel) {
        FacilityText.text = build.name
        print("Name"  + build.name)

        let url = URL(string: FileRoote +  build.image)!
        BuildFacility.kf.setImage(with: url)
    }

}
