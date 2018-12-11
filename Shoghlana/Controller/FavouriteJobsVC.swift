//
//  FavouriteJobsVC.swift
//  Shoghlana
//
//  Created by apple on 8/6/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import MOLH
import NVActivityIndicatorView

class FavouriteJobsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var jobsTableView: UITableView!
    
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    var viewBorderColor:UIColor!
    
    public var jobsModel : JobsModel?
    var jobsList: [JobsData]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SharedHandler.sideMenus(ViewController: self)
        viewBorderColor = UIColor(red: 0.9333, green: 0.9333, blue: 0.9333, alpha: 1)
        
        getFavouriteJobs()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! myJobsTableViewCell
        
        DesignableViews.viewBorderColor(view: cell.cellView, cornerRadius: 5, borderColor: viewBorderColor.cgColor, borderWidth: 2)
        
        cell.selectionStyle = .none
        
        cell.cellJobName.text = jobsList?[indexPath.row].title ?? ""
        cell.cellCompanyName.text = jobsList?[indexPath.row].company ?? ""
        cell.cellJobDate.text = jobsList?[indexPath.row].since ?? ""
        cell.cellCompanyLocation.text = "\(jobsList?[indexPath.row].country ?? "") - \(jobsList?[indexPath.row].city ?? "")"
        
        var imageBaseURLString = "http://shoglana.com/public/jobs/"
        var imageString = "\(imageBaseURLString)\(jobsList?[indexPath.row].logo ?? "")"
        let finalImageString = imageString.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        
        let logoURL = URL(string: (finalImageString) ?? "")
        cell.cellJobPhoto.sd_setImage(with: logoURL, placeholderImage: #imageLiteral(resourceName: "image_placeholder"))
        
        print("finalImageString: ",finalImageString)
        
        cell.selectionStyle = .none
        
        self.activityIndicatorView.stopAnimating()
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            
            self.jobsList?.remove(at: indexPath.row)
            self.jobsTableView.deleteRows(at: [indexPath], with: .automatic)
            jobsTableView.reloadData()
        }
    }
    
    func getFavouriteJobs(){
        self.activityIndicatorView.startAnimating()
        JobsModelRequest().favouriteJobs(controller: self, apiTitle: "Favourite Jobs", view: self.view) { (jobsModel) in
            
            if (jobsModel.jobsData?.count)! > 0 {
                self.jobsList = jobsModel.jobsData
                self.jobsTableView.reloadData()
                
            }else{
                self.activityIndicatorView.stopAnimating()
                if MOLHLanguage.isRTLLanguage(){
                    emptyLabel("لا يوجد وظائف", forController: self)
                }else{
                    emptyLabel("No data here", forController: self)
                }
            }
        }
        
    }
    
    
}
