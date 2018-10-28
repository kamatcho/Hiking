//
//  DesignableTextField.swift
//  Hiking
//
//  Created by MOHAMED on 3/20/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {
    
     @IBInspectable var cornerreadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var rightPadding :CGFloat = 0 {
        didSet {
            updateview()
        }
    }

    @IBInspectable var rightImage : UIImage? {
        didSet {
            updateview()
        }
    }

    func updateview() {
        if let image = rightImage {
            rightViewMode = .always
            let imageview = UIImageView(frame: CGRect(x: rightPadding, y: 0, width: 20, height: 20))
            imageview.image = image
            var width = rightPadding + 20
            if borderStyle  == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line {
                width = width + 5
            }
            let view = UIView(frame: CGRect(x: 0, y: 5, width: width, height: 20))
            view.addSubview(imageview)
            
            rightView =  view
            
        }else{
            rightViewMode = .never
        }
    }
}
