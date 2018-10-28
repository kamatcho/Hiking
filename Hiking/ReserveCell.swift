//
//  ReserveCell.swift
//  Hiking
//
//  Created by MOHAMED on 4/8/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit

class ReserveCell: UITableViewCell {

    @IBOutlet weak var BuildNameText: UILabel!
   
    @IBOutlet weak var ResetveDate: UILabel!
    @IBOutlet weak var ReserveStatus: UILabel!
    
    
    
    func ConfigureCell(reserve : ReseveModel){
        BuildNameText.text = String(reserve.build_id)
        ResetveDate.text = reserve.reserve_date
        if reserve.accept_reserv_by_store == 0 {
            ReserveStatus.text = "لم يكتمل الحجز"
        }else {
            ReserveStatus.text = "مكتمل"
        }
        
    }
    

}
