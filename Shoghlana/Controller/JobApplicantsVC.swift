//
//  JobApplicantsVC.swift
//  Shoghlana
//
//  Created by apple on 8/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class JobApplicantsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    
    
    @IBOutlet weak var jobApplicantsTableView: UITableView!
    

    

    override func viewDidLoad() {
        super.viewDidLoad()

        SharedHandler.sideMenus(ViewController: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! jobApplicantsTableViewCell
        
        cell.delegate = self
        cell.selectionStyle = .none
        
        
        DesignableViews.imageViewBorderColor(view: cell.cellProfilePic, cornerRadius: 35, borderColor: UIColor.darkGray.cgColor, borderWidth: 1)
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    

    //////////
    @objc func viewProfileCellBtnClicked(cell : jobApplicantsTableViewCell) {
        let ind = jobApplicantsTableView.indexPath(for: cell)
        
        do
        {
            
            print("View Profile")
            print("ind",ind!)
            
            
//            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TraderOrderAcceptanceVC")as! TraderOrderAcceptanceVC
//
//            vc.itemsArray = self.List[ind!.row].items!
//            vc.customerName = List[ind!.row].name!
//            vc.orderId = List[ind!.row].id!
//
//
//            navigationController?.pushViewController(vc, animated: true)
            
            
            
            
        }
        catch
        {
            print(error)
        }
    }
    
    /////////
    
    //////////
    @objc func acceptCellBtnClicked(cell : jobApplicantsTableViewCell) {
        let ind = jobApplicantsTableView.indexPath(for: cell)
        
        do
        {
            
            print("Accept")
            print("ind",ind!)
            
            
            //            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TraderOrderAcceptanceVC")as! TraderOrderAcceptanceVC
            //
            //            vc.itemsArray = self.List[ind!.row].items!
            //            vc.customerName = List[ind!.row].name!
            //            vc.orderId = List[ind!.row].id!
            //
            //
            //            navigationController?.pushViewController(vc, animated: true)
            
            
            
            
        }
        catch
        {
            print(error)
        }
    }
    
    /////////
    
    //////////
    @objc func rejectCellBtnClicked(cell : jobApplicantsTableViewCell) {
        let ind = jobApplicantsTableView.indexPath(for: cell)
        
        do
        {
            
            print("Reject")
            print("ind",ind!)
            
            
            //            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TraderOrderAcceptanceVC")as! TraderOrderAcceptanceVC
            //
            //            vc.itemsArray = self.List[ind!.row].items!
            //            vc.customerName = List[ind!.row].name!
            //            vc.orderId = List[ind!.row].id!
            //
            //
            //            navigationController?.pushViewController(vc, animated: true)
            
            
            
            
        }
        catch
        {
            print(error)
        }
    }
    
    /////////


}
