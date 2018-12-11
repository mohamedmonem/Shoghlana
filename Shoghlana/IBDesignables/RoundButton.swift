//
//  RoundButton.swift
//  Kadi
//
//  Created by apple on 12/4/17.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {


    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

}
