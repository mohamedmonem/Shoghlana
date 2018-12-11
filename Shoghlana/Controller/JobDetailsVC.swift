//
//  JobDetailsVC.swift
//  Shoghlana
//
//  Created by apple on 8/7/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import MOLH
import Alamofire
import KMPopUp
import SwiftyJSON

class JobDetailsVC: UIViewController {
    
    @IBAction func favouriteAction(_ sender: Any) {
        print("ffffff")
        addOrRemoveFromFavourites()
    }
    
    @IBAction func chatAction(_ sender: Any) {
        
    }
    
    
    @IBOutlet weak var mainInfoView: UIView!
    @IBOutlet weak var profilePicView: UIView!
    @IBOutlet weak var jobDescriptionView: UIView!
    @IBOutlet weak var jobDetailsView: UIView!
    
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyAddressLabel: UILabel!
    @IBOutlet weak var jobDateLabel: UILabel!
    @IBOutlet weak var jobDescriptionTextView: UITextView!
    @IBOutlet weak var jobSkillsTextView: UITextView!
    @IBOutlet weak var jobDetailsTextView: UITextView!
    
    @IBOutlet weak var jobImageView: UIImageView!
    
    var isFavourite = false
    
    var skillsArray = [String]()
    var skillsString:String = ""
    var userId:String = ""
    var jobId = String()
    
    @IBOutlet weak var skillsView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        userId = UserDefaults.standard.object(forKey: "userId") as? String ?? ""

        DesignableViews.viewBorderColor(view: mainInfoView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 1)
        
        DesignableViews.viewBorderColor(view: profilePicView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 1)
        
        DesignableViews.viewBorderColor(view: jobDescriptionView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 1)
        
        DesignableViews.viewBorderColor(view: skillsView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 1)
        
        DesignableViews.viewBorderColor(view: jobDetailsView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 1)
        
        getSingleJob()
        
        self.activityIndicator.stopAnimating()
        
    }
    

    func getSingleJob(){
        self.activityIndicator.startAnimating()
//        SingleJobModelRequest.singleJob(controller: self, apiTitle: "Job Details", view: self.view) { (data) in
        
      SingleJobModelRequest().singleJob(controller: self, apiTitle: "Job Details", view: self.view) { (data) in
        
        self.jobDescriptionTextView.text = data.singleJobData?.desc ?? ""
        self.jobDetailsTextView.text = data.singleJobData?.details ?? ""
        
        self.jobTitleLabel.text = data.singleJobData?.title ?? ""
        self.companyNameLabel.text = data.singleJobData?.company ?? ""
        self.companyAddressLabel.text = "\(data.singleJobData?.country_id ?? "") - \(data.singleJobData?.city_id ?? "")"
        
        if MOLHLanguage.isRTLLanguage(){
        self.jobDateLabel.text = "تم النشر في \(data.singleJobData?.created_at ?? "")"
        }else{
        self.jobDateLabel.text = "Published on \(data.singleJobData?.created_at ?? "")"
        }
        
        self.skillsArray = (data.singleJobData?.skills)!
        
        for var i in 0..<self.skillsArray.count{
            self.skillsString += "• \(self.skillsArray[i])" + " \n"
        }
        
        self.jobSkillsTextView.text = self.skillsString
        
        var imageBaseURLString = "http://shoglana.com/public/jobs/"
        var imageString = "\(imageBaseURLString)\(data.singleJobData?.logo ?? "")"
        let finalImageString = imageString.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        
        let logoURL = URL(string: (finalImageString) ?? "")
        self.jobImageView.sd_setImage(with: logoURL, placeholderImage: #imageLiteral(resourceName: "image_placeholder"))
        
        self.isFavourite = data.singleJobData?.is_favorite ?? false
        
        let jobIdInt:Int = (data.singleJobData?.id)!
        
        self.jobId = "\(jobIdInt)"

        
        //self.activityIndicator.stopAnimating()
        
        
        }
        //self.activityIndicator.stopAnimating()
    }
    
    public func addOrRemoveFromFavourites(){
        
        self.activityIndicator.startAnimating()
        let parameters = [    "user_id" : userId,
                              "job_id" : jobId]
        
        print(parameters)
        
        let appURL:String = URLHandler.getUrl(for: "job_favorite")
        
        Alamofire.request(appURL, method: .post, parameters: parameters, encoding: JSONEncoding(options: []), headers: nil)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    print("json: ",json)
                    
                    self.activityIndicator.stopAnimating()
                    
                    if MOLHLanguage.isRTL() {
                        KMPoUp.ShowMessageWithDuration(controller: self, message:""
                            , image: #imageLiteral(resourceName: "image_heart"), duration: 1.5)
                    }else{
                        KMPoUp.ShowMessageWithDuration(controller: self, message: "", image: #imageLiteral(resourceName: "image_heart") , duration: 1.5)
                    }
                    
                case .failure(let error):
                    print(error)
                    
                }
        }
        
        
    }
    
}
