import Foundation
import UIKit

class DesignableViews {
    
    
//    static func textFieldInit(view:UITextField , placeHolderText:String,cornerRadius:CGFloat,borderColor:CGColor,borderWidth:CGFloat)  {
//        view.layer.cornerRadius = cornerRadius
//        view.layer.masksToBounds = true
//        view.layer.borderColor = borderColor
//        view.layer.borderWidth = borderWidth
//
//        view.attributedPlaceholder = NSAttributedString(string:placeHolderText,
//                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.orange])
//
//    }
//
//    static func buttonInit(view:UIButton,cornerRadius:CGFloat,borderColor:CGColor,borderWidth:CGFloat )  {
//        view.layer.cornerRadius = cornerRadius
//        view.layer.masksToBounds = true
//        view.layer.borderColor = borderColor
//        view.layer.borderWidth = borderWidth
//
//    }
    
    static func labelBorderColor(view:UILabel,cornerRadius:CGFloat,borderColor:CGColor,borderWidth:CGFloat )  {
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
        view.layer.borderColor = borderColor
        view.layer.borderWidth = borderWidth
        
    }
    
    static func textViewBorderColor(view:UITextView,cornerRadius:CGFloat,borderColor:CGColor,borderWidth:CGFloat )  {
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
        view.layer.borderColor = borderColor
        view.layer.borderWidth = borderWidth
        
    }
    
    
    static func imageViewBorderColor(view:UIImageView,cornerRadius:CGFloat,borderColor:CGColor,borderWidth:CGFloat )  {
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
        view.layer.borderColor = borderColor
        view.layer.borderWidth = borderWidth
        
    }
    
    static func textFieldBorderColor(view:UITextField,cornerRadius:CGFloat,borderColor:CGColor,borderWidth:CGFloat )  {
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
        view.layer.borderColor = borderColor
        view.layer.borderWidth = borderWidth
        
    }
    
    static func viewBorderColor(view:UIView,cornerRadius:CGFloat,borderColor:CGColor,borderWidth:CGFloat )  {
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
        view.layer.borderColor = borderColor
        view.layer.borderWidth = borderWidth
        
    }
    
    
    
    
    
    
    
    
    
}
