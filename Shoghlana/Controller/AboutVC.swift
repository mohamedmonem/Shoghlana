//
//  AboutVC.swift
//  Shoghlana
//
//  Created by apple on 7/27/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class AboutVC: UIViewController {
    
    @IBOutlet weak var aboutUsImageView: UIImageView!
    
    @IBOutlet weak var aboutAppTextView: UITextView!
    @IBOutlet weak var aboutAppLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        SharedHandler.sideMenus(ViewController: self)
        
        DesignableViews.imageViewBorderColor(view: aboutUsImageView, cornerRadius: 0, borderColor: UIColor.lightGray.cgColor, borderWidth: 2)
        
        DesignableViews.labelBorderColor(view: aboutAppLabel, cornerRadius: 0, borderColor: UIColor.lightGray.cgColor, borderWidth: 2)
        
        DesignableViews.textViewBorderColor(view: aboutAppTextView, cornerRadius: 0, borderColor: UIColor.lightGray.cgColor, borderWidth: 2)
        
        getAboutApp()
        
    }

    func getAboutApp(){
        self.activityIndicator.startAnimating()
        SettingModelRequest().aboutApp(controller: self, apiTitle: "Applied App", view: self.view) { (data) in
            
            self.aboutAppTextView.text = data.settingData?.text ?? ""
            self.aboutAppLabel.text = data.settingData?.title ?? ""
            self.activityIndicator.stopAnimating()
        }
        
    }
    
}
