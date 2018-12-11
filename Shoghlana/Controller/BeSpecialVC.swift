//
//  BeSpecialVC.swift
//  Shoghlana
//
//  Created by apple on 7/28/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class BeSpecialVC: UIViewController {

    @IBOutlet weak var beSpecialImageView: UIImageView!
    @IBOutlet weak var beSpecialTextView: UITextView!
    @IBOutlet weak var beSpecialLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SharedHandler.sideMenus(ViewController: self)
        
        DesignableViews.imageViewBorderColor(view: beSpecialImageView, cornerRadius: 0, borderColor: UIColor.lightGray.cgColor, borderWidth: 2)
        
        DesignableViews.textViewBorderColor(view: beSpecialTextView, cornerRadius: 0, borderColor: UIColor.lightGray.cgColor, borderWidth: 2)
        
        DesignableViews.labelBorderColor(view: beSpecialLabel, cornerRadius: 0, borderColor: UIColor.lightGray.cgColor, borderWidth: 2)
        
        


    }

}
