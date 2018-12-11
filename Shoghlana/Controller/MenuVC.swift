//
//  MenuVC.swift
//  Shoghlana
//
//  Created by apple on 8/20/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import KMPopUp
import MOLH


class MenuVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var userType:String = ""
    var userId:String = ""
    var loggedIN:String = ""
    
    @IBOutlet weak var menuTableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    userType = UserDefaults.standard.object(forKey: "userType") as? String ?? ""
    userId = UserDefaults.standard.object(forKey: "userId") as? String ?? ""
    loggedIN = UserDefaults.standard.object(forKey: "loggedIN") as? String ?? ""
    menuTableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    userType = UserDefaults.standard.object(forKey: "userType") as? String ?? ""
    userId = UserDefaults.standard.object(forKey: "userId") as? String ?? ""
    loggedIN = UserDefaults.standard.object(forKey: "loggedIN") as? String ?? ""
    menuTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 21
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell\(indexPath.row)", for: indexPath) as! ProfileDetailsMenuTableViewCell
            
            var userName = UserDefaults.standard.object(forKey: "userName") as? String ?? ""
            var userTitle = UserDefaults.standard.object(forKey: "userTitle") as? String ?? ""
            var userImage = UserDefaults.standard.object(forKey: "userImage") as? String ?? ""
            
            cell.cellName.text = userName
            cell.cellJob.text = userTitle
            //        headerCell.cellImage
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell\(indexPath.row)", for: indexPath)
            cell.selectionStyle = .none
            
            
            if loggedIN == "1" {
                
                if indexPath.row == 20 {
                    let loginCell = cell as! LoginTableViewCell
                    
                    
                    if MOLHLanguage.isRTLLanguage() {
                        loginCell.loginOrLogoutLabel.text = "تسجيل خروج"
                    }else{
                        loginCell.loginOrLogoutLabel.text = "Logout"
                    }
                    
                    return loginCell
                    
                }
                
                
                
            }else{
                
                
                if indexPath.row == 20 {
                    let loginCell = cell as! LoginTableViewCell
                    
                    
                    
                    if MOLHLanguage.isRTLLanguage() {
                        loginCell.loginOrLogoutLabel.text = "تسجيل دخول"
                    }else{
                        loginCell.loginOrLogoutLabel.text = "Login"
                        
                        return loginCell
                        
                    }
                }
                
            }
            
            
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectedCell = indexPath.row
        
        if selectedCell == 0{
            
        }else if selectedCell == 1{
        PushScreens(Identifier: "SWRevealViewController")
        }else if selectedCell == 2{
            
        if userId != "" && userId != "0"{
        PushScreens(Identifier: "MyJobsNC")
        }else{
        mustLoginPopUP()
        }
        
        }else if selectedCell == 3{
        if userId != "" && userId != "0"{
        PushScreens(Identifier: "RecommendedJobsNC")
        }else{
        mustLoginPopUP()
        }
        
        }else if selectedCell == 4{
        if userId != "" && userId != "0"{
        PushScreens(Identifier: "FavouriteJobsNC")
        }else{
        mustLoginPopUP()
        }
        
        }else if selectedCell == 5{
            
        }else if selectedCell == 6{
        if userId != "" && userId != "0"{
        PushScreens(Identifier: "TrainingCoursesNC")
        }else{
        mustLoginPopUP()
        }
        
        }else if selectedCell == 7{
        if userId != "" && userId != "0"{
        PushScreens(Identifier: "JobApplicantsNC")
        }else{
        mustLoginPopUP()
        }
        }else if selectedCell == 8{
        if userId != "" && userId != "0"{
        PushScreens(Identifier: "AddJobNC")
        }else{
        mustLoginPopUP()
        }
        }else if selectedCell == 9{
            
        }else if selectedCell == 10{
            
        }else if selectedCell == 11{
        if userId != "" && userId != "0"{
        PushScreens(Identifier: "PackagesNC")
        }else{
        mustLoginPopUP()
        }
        }else if selectedCell == 12{
            if userId != "" && userId != "0"{
                PushScreens(Identifier: "SuggestionsAndComplaintsNC")
            }else{
                mustLoginPopUP()
            }
        }else if selectedCell == 13{
        PushScreens(Identifier: "AboutNC")
        }else if selectedCell == 14{
            
        }else if selectedCell == 15{
        if userId != "" && userId != "0"{
        PushScreens(Identifier: "ContactAppAdminNC")
        }else{
        mustLoginPopUP()
        }
        
        }else if selectedCell == 16{
            
        }else if selectedCell == 17{
        if userId != "" && userId != "0"{
        PushScreens(Identifier: "NotificationsNC")
        }else{
        mustLoginPopUP()
        }
        }else if selectedCell == 18{
            if userId != "" && userId != "0"{
                PushScreens(Identifier: "SettingsNC")
            }else{
                mustLoginPopUP()
            }
        }else if selectedCell == 19{
        if userId != "" && userId != "0"{
        PushScreens(Identifier: "BeSpecialNC")
        }else{
        mustLoginPopUP()
        }
        }else if selectedCell == 20{
        
            
            if loggedIN == "1"{
                
                UserDefaults.standard.setValue("", forKey: "loggedIN")
                UserDefaults.standard.setValue("", forKey: "userName")
                UserDefaults.standard.setValue("0", forKey: "userId")
                UserDefaults.standard.setValue("", forKey: "userType")
                UserDefaults.standard.synchronize()
                
//                let loginManager = FBSDKLoginManager()
//                loginManager.logOut() // this is an instance function
                
                let mainStorybord = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SplashScreenVC")
                let rvc:SWRevealViewController = self.revealViewController() as SWRevealViewController
                rvc.pushFrontViewController(mainStorybord, animated: true)
                
            }else{
                
            PushScreens(Identifier: "LoginNC")
                
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        
        if userType == "employee"{
        
            switch indexPath.row{
                
            case 0: return 90
            case 7: return 0
            case 8: return 0
            case 9: return 0
            case 10: return 0
            case 11: return 0
            case 19: return 0
                
            default:
                return 55
            }
            
        }else if userType == "employer"{
            
            switch indexPath.row{
            case 0: return 90
                
            case 2: return 0
            case 3: return 0
            case 4: return 0
            case 5: return 0
            
            default:
            return 55
        }
        }
        
        
        if indexPath.row == 0 {
            return 90
        }

        return 55
    }
    
    func PushScreens( Identifier: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Identifier)
        let rvc:SWRevealViewController = self.revealViewController() as SWRevealViewController
        rvc.pushFrontViewController(vc, animated: true)
    }
    
    func mustLoginPopUP(){
        if MOLHLanguage.isRTLLanguage() {
            KMPoUp.ShowMessageWithDuration(controller: self, message:"يجب تسجيل الدخول أولا"
                , image: #imageLiteral(resourceName: "warning"), duration: 1.5)
        }else{
            KMPoUp.ShowMessageWithDuration(controller: self, message: "You must be logged in", image: #imageLiteral(resourceName: "warning"), duration: 1.5)
        }
    }


}
