//
//  roundTextView.swift
//  5rof
//
//  Created by apple on 12/28/17.
//  Copyright © 2017 apple. All rights reserved.
//


import UIKit


@IBDesignable
class DesignabtextView: UITextView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.masksToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }
    
}
