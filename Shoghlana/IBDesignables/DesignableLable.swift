//
//  DesignableLable.swift
//  Kadi
//
//  Created by apple on 12/5/17.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableLable: UILabel {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
             layer.masksToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }

}
