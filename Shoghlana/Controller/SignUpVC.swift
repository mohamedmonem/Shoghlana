//
//  SignUpVC.swift
//  Shoghlana
//
//  Created by apple on 7/26/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import MOLH
import KMPopUp
import NVActivityIndicatorView

class SignUpVC: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var employerView: UIView!
    @IBOutlet weak var employeeView: UIView!
    
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    var type:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func employerBtnClicked(_ sender: Any) {
        type = "employer"
        
        employerView.layer.backgroundColor = UIColor.lightGray.cgColor
        
        employeeView.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    @IBAction func employeeBtnClicked(_ sender: Any) {
        type = "employee"
        
        employeeView.layer.backgroundColor = UIColor.lightGray.cgColor
        
        employerView.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    @IBAction func registerBtnClicked(_ sender: Any) {
        guard nameTextField.text?.isEmpty != true && mobileTextField.text?.isEmpty != true && emailTextField.text?.isEmpty != true && passwordTextField.text?.isEmpty != true && type != "" else {
            
            return fillAllData()
        }
        
        print("Doneeee")
        signUp()
        
    }
    func fillAllData(){
        if MOLHLanguage.isRTL() {
            KMPoUp.ShowMessageWithDuration(controller: self, message: ".من فضلك قم بملأ كافة البيانات"
                , image: #imageLiteral(resourceName: "warning"), duration: 1.5)
        }else{
            KMPoUp.ShowMessageWithDuration(controller: self, message: "Please fill all data.", image: #imageLiteral(resourceName: "warning"), duration: 1.5)
        }
    }
    
    
    func signUp(){
        
        self.activityIndicatorView.startAnimating()
        
        UserModelRequest().Register(parameters: ["first_name":nameTextField.text!,"last_name":".","email":emailTextField.text!,"password":passwordTextField.text!,"password_confirmation":passwordTextField.text!,"type":type], controller: self, apiTitle: "User Registeration", view: self.view) { (data) in
            
            
            var status = data.status ?? ""
            print("Status: ",status)
            
            if status == "success"{
                print("Message: ",data.msg ?? "")
                print("id: ",data.userInfo?.id ?? "")
//              print("type: ",data.userInfo?.type ?? "")
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
                UserDefaults.standard.setValue(self.type, forKey: "userType")
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
    }
    

//"first_name":"Ahmed",
//"last_name":"Ali",
//"email":"ahmedali1@dd.com",
//"password":"123123",
//"password_confirmation":"123123",
//"type":"employee"
