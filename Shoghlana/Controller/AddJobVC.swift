//
//  AddJobVC.swift
//  Shoghlana
//
//  Created by apple on 7/28/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import PTPPlaceholderTextView

class AddJobVC: UIViewController {

    @IBOutlet weak var jobNameView: UIView!
    @IBOutlet weak var jobNameTextField: UITextField!
    
    @IBOutlet weak var aboutJobView: UIView!
    @IBOutlet weak var aboutJobTextView: PTPPlaceholderTextView!
    
    @IBOutlet weak var skillsView: UIView!
    @IBOutlet weak var skillsTextView: PTPPlaceholderTextView!
    
    @IBOutlet weak var dawamView: UIView!
    @IBOutlet weak var dawamTextField: UITextField!
    
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryTextField: UITextField!
    
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var ageView: UIView!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var genderTextField: UITextField!
    
    @IBOutlet weak var workNatureButton: UIButton!
    
    @IBOutlet weak var salaryView: UIView!
    @IBOutlet weak var salaryTextField: UITextField!
    
    @IBOutlet weak var howToApplyButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SharedHandler.sideMenus(ViewController: self)
        
        DesignableViews.viewBorderColor(view: jobNameView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 2)
        DesignableViews.viewBorderColor(view: aboutJobView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 2)
        DesignableViews.viewBorderColor(view: skillsView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 2)
        DesignableViews.viewBorderColor(view: dawamView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 2)
        DesignableViews.viewBorderColor(view: countryView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 2)
        DesignableViews.viewBorderColor(view: cityView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 2)
        DesignableViews.viewBorderColor(view: addressView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 2)
        DesignableViews.viewBorderColor(view: ageView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 2)
        DesignableViews.viewBorderColor(view: genderView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 2)
        DesignableViews.viewBorderColor(view: workNatureButton, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 2)
        DesignableViews.viewBorderColor(view: salaryView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 2)
        DesignableViews.viewBorderColor(view: howToApplyButton, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 2)
//        DesignableViews.textFieldBorderColor(view: jobNameTextField, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 2)
        
      aboutJobTextView.placeholder = "عن الوظيفة"
      skillsTextView.placeholder = "المهارات"
        
        
    }

}
