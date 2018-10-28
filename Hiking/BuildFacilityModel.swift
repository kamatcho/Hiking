//
//  BuildFacilityModel.swift
//  Hiking
//
//  Created by MOHAMED on 4/5/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import SwiftyJSON
class BuildFacilityModel: NSObject {
    var image : String!
    var name : String!
    
    init(Facil :  [String:JSON]) {
        
        if let Name = Facil["name"]?.string {
            self.name = Name
        }
        if let image = Facil["icon_path"]?.string{
            self.image = image
        }
    }

}
