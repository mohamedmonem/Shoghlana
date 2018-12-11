//
//  RoundImage.swift
//  Kadi
//
//  Created by apple on 12/4/17.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit


@IBDesignable
class RoundImage: UIImageView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.masksToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }
    


}
