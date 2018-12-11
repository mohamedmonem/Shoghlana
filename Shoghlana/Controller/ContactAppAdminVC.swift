//
//  ContactAppAdminVC.swift
//  Shoghlana
//
//  Created by apple on 8/11/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import MOLH
import NVActivityIndicatorView
import SDWebImage

class ContactAppAdminVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    var userId = ""
    var userName:String = ""
    
    public var supportMessagesModel : SupportMessagesModel?
    var supportMessagesList: [SupportMessagesData]?
    
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        userId = UserDefaults.standard.object(forKey: "userId") as? String ?? ""
        userName = UserDefaults.standard.object(forKey: "userName") as? String ?? ""
        
        SharedHandler.sideMenus(ViewController: self)
        getSupportMessages()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supportMessagesList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactAppAdminTableViewCell
        
        DesignableViews.imageViewBorderColor(view: cell.cellImage, cornerRadius: 30, borderColor: UIColor.lightGray.cgColor, borderWidth: 1)
        
        var senderId = "\(supportMessagesList?[indexPath.row].sender_id)"
        
        if MOLHLanguage.isRTLLanguage(){
            
            if senderId == userId {
            cell.cellName.text = userName
            }else{
            cell.cellName.text = "مشرف التطبيق"
            }
            
        }else{
            if senderId == userId {
                cell.cellName.text = userName
            }else{
                cell.cellName.text = "Application Admin"
            }
        }
        
        
        cell.cellTime.text = supportMessagesList?[indexPath.row].since
        cell.cellMessage.text = supportMessagesList?[indexPath.row].text
        
//        var imageBaseURLString = "http://shoglana.com/public/jobs/"
//        var imageString = "\(imageBaseURLString)\(supportMessagesList?[indexPath.row].file ?? "")"
//        let finalImageString = imageString.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
//        
//        let logoURL = URL(string: (finalImageString) ?? "")
//        cell.cellImage.sd_setImage(with: logoURL, placeholderImage: #imageLiteral(resourceName: "job_applier"))
        
        self.activityIndicatorView.stopAnimating()
        
        return cell
        
    }

    func getSupportMessages(){
        
        self.activityIndicatorView.startAnimating()
        SupportMessagesModelRequest().getSupportMessages(parameters: ["user_id":userId],controller: self, apiTitle: "Support Messages", view: self.view) { (data) in
            
            if (data.supportMessagesData?.count)! > 0 {
                self.supportMessagesList = data.supportMessagesData
                self.messagesTableView.reloadData()
                
            }else{
                self.activityIndicatorView.stopAnimating()
                if MOLHLanguage.isRTLLanguage(){
                    emptyLabel("لا يوجد رسائل", forController: self)
                }else{
                    emptyLabel("No Messages", forController: self)
                }
            }
        }
        //self.activityIndicatorView.stopAnimating()
    }

}
