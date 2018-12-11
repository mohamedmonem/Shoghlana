//
//  NotificationsViewController.swift
//  Shoghlana
//
//  Created by apple on 9/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import MOLH

class NotificationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var notificationsTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    var viewBorderColor:UIColor!
    
    public var notificationsModel : NotificationsModel?
    var notificationsList: [NotificationsData]?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        SharedHandler.sideMenus(ViewController: self)
        
        getNotifications()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notificationsList?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! NotificationTableViewCell
        
        var viewBorderColor = UIColor(red: 0.9333, green: 0.9333, blue: 0.9333, alpha: 1)
        
        DesignableViews.viewBorderColor(view: cell.notificationView, cornerRadius: 5, borderColor: viewBorderColor.cgColor, borderWidth: 2)
        
        cell.notificationTitle.text = notificationsList?[indexPath.row].title ?? ""
        cell.notificationText.text = notificationsList?[indexPath.row].text ?? ""
        cell.notificationDate.text = notificationsList?[indexPath.row].since ?? ""
        
        cell.selectionStyle = .none
        self.activityIndicatorView.stopAnimating()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    func getNotifications(){
        self.activityIndicatorView.startAnimating()
        NotificationsModelRequest().getNotifications(controller: self, apiTitle: "Notifications", view: self.view) { (data) in
            
            if (data.notificationsData?.count)! > 0 {
                self.notificationsList = data.notificationsData
                self.notificationsTableView.reloadData()
                
            }else{
                self.activityIndicatorView.stopAnimating()
                if MOLHLanguage.isRTLLanguage(){
                    emptyLabel("لا يوجد إشعارات", forController: self)
                }else{
                    emptyLabel("No Notifications", forController: self)
                }
            }
        }
        
    }
    
}
