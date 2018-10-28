//
//  AboutModel.swift
//  Hiking
//
//  Created by MOHAMED on 3/30/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class AboutModel {
    var id : Int!
    var title : String!
    var content : String!
    init(Pages : [String:JSON]) {
        if let ID = Pages["id"]?.int{
            self.id = ID
        }
        if let title = Pages["name"]?.string {
            self.title = title
        }
        if let content = Pages["content"]?.string{
            self.content = content
        }
        
    }

}
