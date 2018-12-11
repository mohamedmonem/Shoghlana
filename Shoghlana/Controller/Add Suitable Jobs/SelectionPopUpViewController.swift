//
//  SelectionPopUpViewController.swift
//  Shoghlana
//
//  Created by apple on 9/28/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class SelectionPopUpViewController: UIViewController {

    var positionsList = [HomePositionsData]()
    var levelsList = [HomeLevelsData]()
    var countriesList = [HomeCountriesData]()
    
    var dataType = ""
    
    @IBOutlet weak var popUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        popUpView.layer.cornerRadius = 8
        popUpView.layer.masksToBounds = true
        
    }
    
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
            self.removeAnimate()
        }
        
        
    }
    
    
    

}

extension SelectionPopUpViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataType == "jobRole"{
            return positionsList.count ?? 0
        }else if dataType == "jobProfessionalLevel"{
            return levelsList.count ?? 0
        }else if dataType == "suitableJobCountry"{
           return countriesList.count ?? 0
        } else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        
        if dataType == "jobRole"{
        cell.textLabel?.text = positionsList[indexPath.row].name ?? ""
        }else if dataType == "jobProfessionalLevel"{
        cell.textLabel?.text = levelsList[indexPath.row].name ?? ""
        }else if dataType == "suitableJobCountry"{
        cell.textLabel?.text = countriesList[indexPath.row].name ?? ""
        }
        return cell

        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if dataType == "jobRole"{
            var jobRole:String = positionsList[indexPath.row].name ?? ""
        UserDefaults.standard.setValue(jobRole, forKey: "jobRole")
        UserDefaults.standard.setValue(positionsList[indexPath.row].id ?? "", forKey: "jobRoleId")
        showMainPopUp()
            
        //self.removeAnimate()
 
        }else if dataType == "jobProfessionalLevel"{
            var jobProfessionalLevel:String = levelsList[indexPath.row].name ?? ""
            UserDefaults.standard.setValue(jobProfessionalLevel, forKey: "jobProfessionalLevel")
            UserDefaults.standard.setValue(levelsList[indexPath.row].id ?? "", forKey: "jobProfessionalLevelId")
            showMainPopUp()
        }else if dataType == "suitableJobCountry"{
            var suitableJobCountry:String = countriesList[indexPath.row].name ?? ""
            UserDefaults.standard.setValue(suitableJobCountry, forKey: "suitableJobCountry")
            UserDefaults.standard.setValue(countriesList[indexPath.row].id ?? "", forKey: "suitableJobCountryId")
            showMainPopUp()
        }
        
    }
    
    
    func showMainPopUp(){
        let mainStorybord: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = mainStorybord.instantiateViewController(withIdentifier: "AddSuitableJobPopUpViewController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = VC
    }
    
}
