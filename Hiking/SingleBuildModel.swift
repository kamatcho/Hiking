//
//  SingleBuildModel.swift
//  Hiking
//
//  Created by MOHAMED on 4/3/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import SwiftyJSON
class SinglsBuildModel {
    
    var id : Int!
    var name : String!
    var price : String!
    var city : String!
    var image : String!
    var area : String!
    
    
    
    
    init(SingleDict : [String:JSON]) {
        if let ID = SingleDict["id"]?.int{
            self.id = ID
            print(ID)
        }
        
        if let Name = SingleDict["name"]?.string {
            self.name = Name
        }
        if let City = SingleDict["location_rest_area"]?.string {
            self.city = City
        }
        if let Area = SingleDict["location_rest_area"]?.string{
            self.area = Area
        }
        if let Price = SingleDict["middle_week"]?.string{
            self.price = Price
        }
        if let Image = SingleDict["photo"]?.string{
            self.image = FileRoote + Image
        }
        
    }
    
}

