//
//  DatesPickerViewController.swift
//  Hiking
//
//  Created by MOHAMED on 4/16/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit

class DatesPickerViewController: UIViewController {
    
    var completion: ((_ date: Date) -> ())!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(self.hide))
        self.view.addGestureRecognizer(tapGest)
        //        tapGest.delegate = self
    }
    
    
    
    func hide() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func DismissBu(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func PickBu(_ sender: Any) {
        self.completion(self.datePicker.date)
        // print(self.datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension UIViewController {
    
    func showDatesPickerViewController(completion: @escaping (_ date: Date) -> ()) {
        let datesPicker = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DatesPickerViewController") as! DatesPickerViewController
        
        datesPicker.completion = completion
        datesPicker.modalPresentationStyle = .custom
        
        self.present(datesPicker, animated: true, completion: nil)
    }
    
    
}


