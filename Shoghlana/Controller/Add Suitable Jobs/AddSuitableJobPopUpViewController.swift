//
//  AddSuitableJobPopUpViewController.swift
//  Shoghlana
//
//  Created by apple on 9/28/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class AddSuitableJobPopUpViewController: UIViewController {

    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var popUpStackView: UIStackView!
    
    @IBOutlet weak var jobTitleTextField:UITextField!
    
    @IBOutlet weak var jobRoleButton:UIButton!
    
    @IBOutlet weak var jobProfessionalLevelButton:UIButton!
    @IBOutlet weak var jobCountryButton:UIButton!
    
    
    

    public var homeModel : HomeModel?
    var jobsList = [HomeJobsData]()
    var countriesList = [HomeCountriesData]()
    var positionsList = [HomePositionsData]()
    var levelsList = [HomeLevelsData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getHome()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        popUpView.layer.cornerRadius = 8
        popUpView.layer.masksToBounds = true
        var jobRole:String = UserDefaults.standard.object(forKey: "jobRole") as? String ?? ""
        
        var jobProfessionalLevel:String = UserDefaults.standard.object(forKey: "jobProfessionalLevel") as? String ?? ""
        
        var suitableJobCountry:String = UserDefaults.standard.object(forKey: "suitableJobCountry") as? String ?? ""
        
        var jobTitle:String = UserDefaults.standard.object(forKey: "jobTitle") as? String ?? ""
        
        
        print("selected job role: ",jobRole)
        
        self.jobTitleTextField.text = jobTitle
        self.jobRoleButton.setTitle(jobRole, for: .normal)
        self.jobProfessionalLevelButton.setTitle(jobProfessionalLevel, for: .normal)
        self.jobCountryButton.setTitle(suitableJobCountry, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//    jobRoleButton.setTitle(UserDefaults.standard.object(forKey: "jobRole") as? String ?? "", for: .normal)
//    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    @IBAction func closePopUp(_ sender: AnyObject) {
        self.removeAnimate()
        //self.view.removeFromSuperview()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var touch: UITouch? = touches.first
        
        if touch?.view == self.view {
        //self.removeAnimate()
            
//            let mainStorybord: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let VC = mainStorybord.instantiateViewController(withIdentifier: "SWRevealViewController")
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window!.rootViewController = VC
            backToHome()
        }
        
        
    }
    
    

    
    
    @IBAction func showSelectionPopUp(sender: UIButton){
        
    UserDefaults.standard.setValue(jobTitleTextField.text, forKey: "jobTitle")
        
        if sender.tag == 0 {
            var selectionPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectionPopUpViewController") as! SelectionPopUpViewController
            
            selectionPopUpVC.dataType = "jobRole"
            
            if positionsList.count > 0 {
                selectionPopUpVC.positionsList = positionsList
            }
            
            self.addChildViewController(selectionPopUpVC)
            selectionPopUpVC.view.frame = self.view.frame
            self.view.addSubview(selectionPopUpVC.view)
            selectionPopUpVC.didMove(toParentViewController: self)
        }else if sender.tag == 1 {
            let selectionPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectionPopUpViewController") as! SelectionPopUpViewController
            
            if levelsList.count > 0 {
                selectionPopUpVC.levelsList = levelsList
            }
            
            selectionPopUpVC.dataType = "jobProfessionalLevel"
            
            self.addChildViewController(selectionPopUpVC)
            selectionPopUpVC.view.frame = self.view.frame
            self.view.addSubview(selectionPopUpVC.view)
            selectionPopUpVC.didMove(toParentViewController: self)
        }else if sender.tag == 2 {
            let selectionPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectionPopUpViewController") as! SelectionPopUpViewController
            
            if countriesList.count > 0 {
                selectionPopUpVC.countriesList = countriesList
            }
            
            selectionPopUpVC.dataType = "suitableJobCountry"
            
            self.addChildViewController(selectionPopUpVC)
            selectionPopUpVC.view.frame = self.view.frame
            self.view.addSubview(selectionPopUpVC.view)
            selectionPopUpVC.didMove(toParentViewController: self)
        }
        
    }
    
    func getHome(){
        //self.activityIndicatorView.startAnimating()
        HomeModelRequest().getHome(controller: self, apiTitle: "Home", view: self.view) { (data) in
            
            if (data.homeJobsData?.count)! > 0 {
                
                //self.jobsTableView.reloadData()
                
                print("dataaaa: ",data)
                print("homeJobs count: ",data.homeJobsData?.count)
                self.jobsList = data.homeJobsData!
                print("iiii: ",self.jobsList.count)
                
                print("title[0]: ",self.jobsList[0].title)
                
                
                
            }else{
                //                //self.activityIndicatorView.stopAnimating()
                //                if MOLHLanguage.isRTLLanguage(){
                //                    emptyLabel("لا يوجد وظائف", forController: self)
                //                }else{
                //                    emptyLabel("No Jobs here", forController: self)
                //                }
            }
            
            if (data.homeCountriesData?.count)! > 0 {
                
                //self.jobsTableView.reloadData()
                
                print("dataaaa: ",data)
                print("homeCountries count: ",data.homeCountriesData?.count)
                self.countriesList = data.homeCountriesData!
                print("cccc: ",self.countriesList.count)
                
                print("name[0]: ",self.countriesList[0].name)
                
                
                
                
            }else{
                //                //self.activityIndicatorView.stopAnimating()
                //                if MOLHLanguage.isRTLLanguage(){
                //                    emptyLabel("لا يوجد وظائف", forController: self)
                //                }else{
                //                    emptyLabel("No Jobs here", forController: self)
                //                }
            }
            
            if (data.homeLevelsData?.count)! > 0 {
                
                //self.jobsTableView.reloadData()
                
                print("dataaaa: ",data)
                print("homeLevelsData count: ",data.homeLevelsData?.count)
                self.levelsList = data.homeLevelsData!
                print("lllll: ",self.levelsList.count)
                
                print("level name[0]: ",self.levelsList[0].name)
                
                
                
            }else{
                //                //self.activityIndicatorView.stopAnimating()
                //                if MOLHLanguage.isRTLLanguage(){
                //                    emptyLabel("لا يوجد وظائف", forController: self)
                //                }else{
                //                    emptyLabel("No Jobs here", forController: self)
                //                }
            }
            
            if (data.homePositionsData?.count)! > 0 {
                
                //self.jobsTableView.reloadData()
                
                print("dataaaa: ",data)
                print("homePositionsData count: ",data.homePositionsData?.count)
                self.positionsList = data.homePositionsData!
                print("ppppp: ",self.positionsList.count)
                
                print("position name[0]: ",self.positionsList[0].name)
                
                
            }else{
                //                //self.activityIndicatorView.stopAnimating()
                //                if MOLHLanguage.isRTLLanguage(){
                //                    emptyLabel("لا يوجد وظائف", forController: self)
                //                }else{
                //                    emptyLabel("No Jobs here", forController: self)
                //                }
            }
            
            
        }
        
    }
    
    @IBAction func saveAction(sender:UIButton){
        backToHome()
    }
    
    @IBAction func cancelAction(sender:UIButton){
        backToHome()
    }
    
    func backToHome(){
        
        UserDefaults.standard.setValue("", forKey: "jobTitle")
        
        UserDefaults.standard.setValue("", forKey: "jobRole")
        UserDefaults.standard.setValue("", forKey: "jobRoleId")
        
        UserDefaults.standard.setValue("", forKey: "jobProfessionalLevel")
        UserDefaults.standard.setValue("", forKey: "jobProfessionalLevelId")
        
        UserDefaults.standard.setValue("", forKey: "suitableJobCountry")
        UserDefaults.standard.setValue("", forKey: "suitableJobCountryId")
        
        let mainStorybord: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = mainStorybord.instantiateViewController(withIdentifier: "SWRevealViewController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = VC
    }

}
