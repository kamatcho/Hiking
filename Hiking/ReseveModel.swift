//
//  ReseveModel.swift
//  Hiking
//
//  Created by MOHAMED on 4/8/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import SwiftyJSON
class ReseveModel: NSObject {
    
    var id : Int!
    var build_id : Int!
    var reserve_date : String!
    var accept_reserv_by_store : Int!
   
    
    
    
    
    init(ReserveDict : [String:JSON]) {
        if let ID = ReserveDict["id"]?.int{
            self.id = ID
            print(ID)
        }
        
    
        if let Build = ReserveDict["build_id"]?.int{
            self.build_id = Build
        }
        if let Accept = ReserveDict["accept_reserv_by_store"]?.int{
            self.accept_reserv_by_store = Accept
        }
        
        if let reserveDate = ReserveDict["created_at"]?.string{
            
            self.reserve_date = reserveDate
        }
        
    }

}
