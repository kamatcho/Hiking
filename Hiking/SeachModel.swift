//
//  SeachModel.swift
//  Hiking
//
//  Created by MOHAMED on 4/2/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import SwiftyJSON
class SeachModel: NSObject {
    
    var id : Int!
    var name : String!
    var price : String!
    var city : String!
    var image : String!
    var area : String!
    
    
    
    
    init(SearchDict : [String:JSON]) {
        if let ID = SearchDict["id"]?.int{
            self.id = ID
            print(ID)
        }
        
        if let Name = SearchDict["name"]?.string {
            self.name = Name
        }
        if let City = SearchDict["location_rest_area"]?.string {
            self.city = City
        }
        if let Area = SearchDict["location_rest_area"]?.string{
            self.area = Area
        }
        if let Price = SearchDict["middle_week"]?.string{
            self.price = Price
        }
        if let Image = SearchDict["photo"]?.string{
            self.image = FileRoote + Image
        }
        
    }

}
