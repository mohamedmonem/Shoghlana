//
//  PackagesVC.swift
//  Shoghlana
//
//  Created by apple on 8/11/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class PackagesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var packagesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SharedHandler.sideMenus(ViewController: self)


    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PackagesTableViewCell
        
        cell.delegate = self
        cell.selectionStyle = .none
        
        DesignableViews.viewBorderColor(view: cell.cellView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 1)
        
        
        return cell
    }

    
    //////////
    @objc func registerCellBtnClicked(cell : PackagesTableViewCell) {
        let ind = packagesTableView.indexPath(for: cell)
        
        do
        {
            
            print("Register")
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
