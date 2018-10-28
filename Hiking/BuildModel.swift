//
//  BuildModel.swift
//  Hiking
//
//  Created by MOHAMED on 3/26/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import SwiftyJSON
class BuildModel {
    var id : Int!
    var name : String!
    var city : String!
    var area : String!
    var price : String!
    var image : String!
    init(BuildDect : [String:JSON]) {
        if let ID = BuildDect["id"]?.int{
            self.id = ID
        }
        
        if let Name = BuildDect["name"]?.string {
            self.name = Name
        }
        if let City = BuildDect["location_rest_city"]?.string {
            self.city = City
        }
        if let Area = BuildDect["location_rest_area"]?.string{
            self.area = Area
        }
        if let Price = BuildDect["middle_week"]?.string{
            self.price = Price
        }
        if let Image = BuildDect["photo"]?.string{
            self.image = FileRoote + Image
        }
        
    }
}
