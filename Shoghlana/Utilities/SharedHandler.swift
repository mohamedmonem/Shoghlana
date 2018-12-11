//
//  SharedHandler.swift
//  Shoghlana
//
//  Created by apple on 8/20/18.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation
import MOLH

class SharedHandler {
    
    
    ////////////////// Side Menu ///////////////////////////////
    static var sideButton : UIBarButtonItem!
    
    static func setSideImage()  {
        let image = UIImage(named: "menu_icon")
        
        sideButton = UIBarButtonItem(image: image,  style: .plain , target: self, action: Selector(("didTapEditButton:")))
    }
    
    static func sideMenus(ViewController control: UIViewController)
    {
        setSideImage()
        if control.revealViewController() != nil
        {
            if MOLHLanguage.isRTL() {
                
                // right setting
                sideButton.target = control.revealViewController()
                sideButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
                control.navigationItem.leftBarButtonItem = sideButton
                control.revealViewController().rearViewRevealWidth = UIScreen.main.bounds.width - 50.0
                control.revealViewController().frontViewController.view.addGestureRecognizer(control.revealViewController().tapGestureRecognizer())
            }
            else {
                // left setting
                sideButton.target = control.revealViewController()
                sideButton.action = #selector(SWRevealViewController.revealToggle(_:))
                control.navigationItem.leftBarButtonItem = sideButton
                control.revealViewController().rightViewRevealWidth = UIScreen.main.bounds.width - 50.0
                control.revealViewController().frontViewController.view.addGestureRecognizer(control.revealViewController().tapGestureRecognizer())
            }
            
        }
    }
    
    
    
}
