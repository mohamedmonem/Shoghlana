//
//  ViewController.swift
//  Shoghlana
//
//  Created by apple on 7/25/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class SplashScreenVC: UIViewController {

    var isLogged:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLogged = UserDefaults.standard.object(forKey: "loggedIN") as? String ?? ""
        
        if isLogged == "1"{
        perform(#selector(isUser), with: nil, afterDelay: 2)
        }else{
        perform(#selector(notUser), with: nil, afterDelay: 2)
        }
    }

    
    @objc func isUser(){
        
        let mainStorybord: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = mainStorybord.instantiateViewController(withIdentifier: "SWRevealViewController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = VC
        
    }
    
    @objc func notUser(){
        
        let mainStorybord: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = mainStorybord.instantiateViewController(withIdentifier: "LoginVC")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = VC
        
    }


}

