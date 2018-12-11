//
//  LoginVC.swift
//  Shoghlana
//
//  Created by apple on 7/25/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import MOLH
import KMPopUp
import JHSpinner

class LoginVC: UIViewController {

    @IBOutlet weak var emailOrPhoneTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SharedHandler.sideMenus(ViewController: self)
        
    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        
        if emailOrPhoneTextField.text?.isEmpty != true && passwordTextField.text?.isEmpty != true {
        userLogin()
        }else{
            if MOLHLanguage.isRTLLanguage() {
                KMPoUp.ShowMessageWithDuration(controller: self, message:"من فضلك قم بكتابة البريد الإلكتروني وكلمة المرور"
                    , image: #imageLiteral(resourceName: "warning"), duration: 1.5)
            }else{
                KMPoUp.ShowMessageWithDuration(controller: self, message: "Please enter your email and password.", image: #imageLiteral(resourceName: "warning"), duration: 1.5)
            }
        }
        
    }
    
    @IBAction func skipBtnClicked1(_ sender: Any) {
        let mainStorybord: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = mainStorybord.instantiateViewController(withIdentifier: "SWRevealViewController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = VC
    }
    
    @IBAction func skipBtnClicked2(_ sender: Any) {
        let mainStorybord: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = mainStorybord.instantiateViewController(withIdentifier: "SWRevealViewController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = VC
    }
    
    
    func userLogin(){
        
        
        self.activityIndicatorView.startAnimating()
        
        
        UserModelRequest().Login(parameters: ["email":emailOrPhoneTextField.text!,"password":passwordTextField.text!], controller: self, apiTitle: "User Login", view: self.view) { (data) in
            
            
            
            var status = data.status ?? ""
            print("Status: ",status)
            
            if status == "success"{
            print("Message: ",data.msg ?? "")
            print("id: ",data.userInfo?.id ?? "")
            print("type: ",data.userInfo?.type ?? "")
            print("name: ",data.userInfo?.name ?? "")
            print("title: ",data.userInfo?.title ?? "")
            print("image: ",data.userInfo?.image ?? "")
                
                var userId = data.userInfo?.id ?? 0
                
                var userIdString = ("\(userId)")
                
                print("userIdString: ",userIdString)
                
                UserDefaults.standard.setValue(userIdString, forKey: "userId")
                UserDefaults.standard.setValue(data.userInfo?.name ?? "", forKey: "userName")
                UserDefaults.standard.setValue(data.userInfo?.title ?? "", forKey: "userTitle")
                UserDefaults.standard.setValue(data.userInfo?.image ?? "", forKey: "userImage")
                UserDefaults.standard.setValue("1", forKey: "loggedIN")
                UserDefaults.standard.setValue(data.userInfo?.type ?? "", forKey: "userType")
                UserDefaults.standard.synchronize()
                
                self.activityIndicatorView.stopAnimating()
                
                let mainStorybord: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let VC = mainStorybord.instantiateViewController(withIdentifier: "SWRevealViewController")
                UIApplication.shared.keyWindow?.rootViewController = VC
                
                
                
            }else{
                
                self.activityIndicatorView.stopAnimating()
                
                if MOLHLanguage.isRTL() {
                    KMPoUp.ShowMessageWithDuration(controller: self, message:                        "هنالك خطأ في البريد الإلكتروني أو كلمة المرور"
                        
                        , image: #imageLiteral(resourceName: "warning"), duration: 1.5)
                }else{
                    KMPoUp.ShowMessageWithDuration(controller: self, message: "Your email or password is wrong.", image: #imageLiteral(resourceName: "warning"), duration: 1.5)
                }
            }
            
        }
        
        self.activityIndicatorView.stopAnimating()
    }
    
//    public func userLogin(){
//
//        self.activityIndicatorView.startAnimating()
//        let parameters = ["email":emailOrPhoneTextField.text!,
//                          "password":passwordTextField.text!]
//
//        print(parameters)
//
//        let appURL:String = URLHandler.getUrl(for: "login")
//
//        Alamofire.request(appURL, method: .post, parameters: parameters, encoding: JSONEncoding(options: []), headers: nil)
//            .responseJSON { (response) in
//                switch response.result {
//                case .success(let value):
//                    let json = JSON(value)
//
//                    let status = json["status"].string!
//
//                    print("status: ",status)
//
//                    if status == "success" {
//
//                        let info =  json["info"].dictionary!
//
//                        print("info: ",info)
//
//                        let name = info["name"]?.string!
//                        let id = info["id"]?.int!
//                        let title = info["title"]?.string!
//                        let image = info["image"]?.string!
//                        let type = info["type"]?.string!
//
//                        print("user name: ",name!)
//                        print("user id: ",id!)
//                        print("user title: ",title!)
//                        print("user image: ",image!)
//
//                        UserDefaults.standard.setValue(id, forKey: "userId")
//                        UserDefaults.standard.setValue(name, forKey: "userName")
//                        UserDefaults.standard.setValue(title, forKey: "userTitle")
//                        UserDefaults.standard.setValue(image, forKey: "userImage")
//                        UserDefaults.standard.setValue("1", forKey: "loggedIN")
//                        UserDefaults.standard.setValue(type, forKey: "userType")
//                        UserDefaults.standard.synchronize()
//
//                        let mainStorybord: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                        let VC = mainStorybord.instantiateViewController(withIdentifier: "SWRevealViewController")
//                        UIApplication.shared.keyWindow?.rootViewController = VC
//
//                    }else{
//
//
//                        if MOLHLanguage.isRTL() {
//                            KMPoUp.ShowMessageWithDuration(controller: self, message:                        "هنالك خطأ في البريد الإلكتروني أو كلمة المرور"
//
//                                , image: #imageLiteral(resourceName: "warning"), duration: 1.5)
//                        }else{
//                            KMPoUp.ShowMessageWithDuration(controller: self, message: "Your email or password is wrong.", image: #imageLiteral(resourceName: "warning"), duration: 1.5)
//                        }
//
//                    }
//
//
//
//
//                    self.activityIndicatorView.stopAnimating()
//
//                case .failure(let error):
//                    print(error)
//
//                    if MOLHLanguage.isRTL() {
//                        KMPoUp.ShowMessageWithDuration(controller: self, message:                        "تعذر الاتصال بالخادم"
//
//                            , image: #imageLiteral(resourceName: "warning"), duration: 1.5)
//                    }else{
//                        KMPoUp.ShowMessageWithDuration(controller: self, message: "Server connection error.", image: #imageLiteral(resourceName: "warning"), duration: 1.5)
//                    }
//
//                    self.activityIndicatorView.stopAnimating()
//
//                }
//        }
//
//
//    }
    
    
    @IBAction func createAccountBtnClicked(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC")as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
