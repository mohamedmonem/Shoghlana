//
//  AccountDetailsViewController.swift
//  Shoghlana
//
//  Created by apple on 11/26/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class AccountSettingsViewController: UIViewController {

    @IBOutlet weak var userNameLabel:UILabel!
    @IBOutlet weak var userJobLabel:UILabel!
    @IBOutlet weak var userImage:UIImageView!
    
    @IBOutlet weak var notificationsSettingsButton:UIButton!
    @IBOutlet weak var changeEmailButton:UIButton!
    @IBOutlet weak var changePasswordButton:UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func emailButtonClicked(){
    self.performSegue(withIdentifier: "showChangeEmail", sender: self)
    }
    
    @IBAction func notificationsSettingsButtonClicked(){
        self.performSegue(withIdentifier: "showNotificationsSettings", sender: self)
    }
    
    @IBAction func changePasswordButtonClicked(){
        self.performSegue(withIdentifier: "showChangePassword", sender: self)
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
