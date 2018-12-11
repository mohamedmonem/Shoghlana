//
//  HomeVC.swift
//  Shoghlana
//
//  Created by apple on 8/20/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import MOLH
import SDWebImage


class HomeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    
    public var homeModel : HomeModel?
    var jobsList = [HomeJobsData]()
    var countriesList = [HomeCountriesData]()
    var positionsList = [HomePositionsData]()
    var levelsList = [HomeLevelsData]()
    
    //@IBOutlet weak var activityIndicatorView:NVActivityIndicatorView!
    
    @IBOutlet weak var jobsCollectionView:UICollectionView!
    @IBOutlet weak var countriesCollectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SharedHandler.sideMenus(ViewController: self)

        getHome()
        
        
    }
    
    @IBAction func addSuitableJobsAction(){
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddSuitableJobPopUpViewController") as! AddSuitableJobPopUpViewController
        
        if positionsList.count > 0 {
        popUpVC.positionsList = positionsList
        }
        if levelsList.count > 0 {
        popUpVC.levelsList = levelsList
        }
        if countriesList.count > 0 {
        popUpVC.countriesList = countriesList
        }
        self.addChildViewController(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
        return jobsList.count
        }else{
        return countriesList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            
            let jobCell = collectionView.dequeueReusableCell(withReuseIdentifier: "jobCell", for: indexPath) as! HomeJobsCollectionViewCell
            
            jobCell.cellView.layer.cornerRadius = 10
            jobCell.cellView.layer.masksToBounds = true
            
            jobCell.jobLogo.layer.cornerRadius = 27.5
            jobCell.jobLogo.layer.masksToBounds = true
            
            
            jobCell.jobTitle.text = jobsList[indexPath.row].title ?? ""
            jobCell.companyName.text = jobsList[indexPath.row].company ?? ""
            
            var imageString = "http://shoglana.com/public/jobs/\(jobsList[indexPath.row].logo ?? "")"
            
            let finalImageString = imageString.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
            
            print("finalImageString: ",finalImageString)
            
            let imageURL = URL(string: (finalImageString) ?? "")
            jobCell.jobLogo.sd_setImage(with: imageURL, placeholderImage: #imageLiteral(resourceName: "image_placeholder"))
            
            return jobCell
            
        }else{
        
        let countryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as! HomeCountriesCollectionViewCell
        
        countryCell.cellView.layer.cornerRadius = 10
        countryCell.cellView.layer.masksToBounds = true
        
        countryCell.countryName.text = countriesList[indexPath.row].name! ?? ""
        
        if MOLHLanguage.isRTLLanguage() {
        countryCell.jobsCount.text = "\(countriesList[indexPath.row].count ?? 0) وظيفة"
        }else{
        countryCell.jobsCount.text = "\(countriesList[indexPath.row].count ?? 0) Job"
        }
        
        var imageString = "http://shoglana.com/public/countries/\(countriesList[indexPath.row].image ?? "")"
        
        let finalImageString = imageString.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        
        print("finalImageString: ",finalImageString)
        
        let imageURL = URL(string: (finalImageString) ?? "")
        countryCell.countryImage.sd_setImage(with: imageURL, placeholderImage: #imageLiteral(resourceName: "image_placeholder"))
        
        return countryCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    func getHome(){
        //self.activityIndicatorView.startAnimating()
        HomeModelRequest().getHome(controller: self, apiTitle: "Home", view: self.view) { (data) in
            
            if (data.homeJobsData?.count)! > 0 {
                
                //self.jobsTableView.reloadData()
                
                print("dataaaa: ",data)
                print("homeJobs count: ",data.homeJobsData?.count)
                self.jobsList = data.homeJobsData!
                print("iiii: ",self.jobsList.count)
                
                print("title[0]: ",self.jobsList[0].title)
                
                self.jobsCollectionView.reloadData()
                
            }else{
//                //self.activityIndicatorView.stopAnimating()
//                if MOLHLanguage.isRTLLanguage(){
//                    emptyLabel("لا يوجد وظائف", forController: self)
//                }else{
//                    emptyLabel("No Jobs here", forController: self)
//                }
            }
            
            if (data.homeCountriesData?.count)! > 0 {
                
                //self.jobsTableView.reloadData()
                
                print("dataaaa: ",data)
                print("homeCountries count: ",data.homeCountriesData?.count)
                self.countriesList = data.homeCountriesData!
                print("cccc: ",self.countriesList.count)
                
                print("name[0]: ",self.countriesList[0].name)
                
                
                self.countriesCollectionView.reloadData()
                
            }else{
                //                //self.activityIndicatorView.stopAnimating()
                //                if MOLHLanguage.isRTLLanguage(){
                //                    emptyLabel("لا يوجد وظائف", forController: self)
                //                }else{
                //                    emptyLabel("No Jobs here", forController: self)
                //                }
            }
            
            if (data.homeLevelsData?.count)! > 0 {
                
                //self.jobsTableView.reloadData()
                
                print("dataaaa: ",data)
                print("homeLevelsData count: ",data.homeLevelsData?.count)
                self.levelsList = data.homeLevelsData!
                print("lllll: ",self.levelsList.count)
                
                print("level name[0]: ",self.levelsList[0].name)
                
                
                
            }else{
                //                //self.activityIndicatorView.stopAnimating()
                //                if MOLHLanguage.isRTLLanguage(){
                //                    emptyLabel("لا يوجد وظائف", forController: self)
                //                }else{
                //                    emptyLabel("No Jobs here", forController: self)
                //                }
            }
            
            if (data.homePositionsData?.count)! > 0 {
                
                //self.jobsTableView.reloadData()
                
                print("dataaaa: ",data)
                print("homePositionsData count: ",data.homePositionsData?.count)
                self.positionsList = data.homePositionsData!
                print("ppppp: ",self.positionsList.count)
                
                print("position name[0]: ",self.positionsList[0].name)
                
                
            }else{
                //                //self.activityIndicatorView.stopAnimating()
                //                if MOLHLanguage.isRTLLanguage(){
                //                    emptyLabel("لا يوجد وظائف", forController: self)
                //                }else{
                //                    emptyLabel("No Jobs here", forController: self)
                //                }
            }
            
            
        }
        
    }
}

