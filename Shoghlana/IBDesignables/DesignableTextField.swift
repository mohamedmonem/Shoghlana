//
//  DesignableTextField.swift
//  grand
//
//  Created by apple on 12/3/17.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {
    
    @IBInspectable var cornerRadios: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadios
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
        @IBInspectable var leftImage: UIImage? {
            didSet {
                updateRightView()
            }
        }
        @IBInspectable var leftPading: CGFloat = 0 {
            didSet {
                updateRightView()
            }
        }
    
    @IBInspectable var imageHeight: CGFloat = 20 {
        didSet {
            if imageHeight > 20 {
                updateRightView()
            }
        }
    }
    
    @IBInspectable var imageWidth: CGFloat = 20 {
        didSet {
            if imageWidth > 20 {
                updateRightView()
            }
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateRightView()
        }
    }
    
    
    
    @IBInspectable var rightPading: CGFloat = 0 {
        didSet {
            updateRightView()
        }
    }
    
    
    
        func updateView() {
            if let image = leftImage {
                leftViewMode = .always
    
                let imageView = UIImageView(frame: CGRect(x: leftPading, y: 0, width: imageWidth, height: imageHeight))
                imageView.image = image
    
                var width = leftPading + 20
                if borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line {
                    width = width + 5
                }
                let view = UIView(frame : CGRect(x: 0, y: 0, width: width, height: 20))
                view.addSubview(imageView)
    
                leftView = view
            } else {
                // image is nill
                leftViewMode = .never
            }
        }
    
    func updateRightView() {
        if let image = rightImage {
            rightViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageHeight, height: imageWidth))
            imageView.image = image
            
            var width = rightPading + 20
            if borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line {
                width = width + 5
            }
            let view = UIView(frame : CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
            
            rightView = view
        } else {
            // image is nill
            rightViewMode = .never
        }
    }
}

