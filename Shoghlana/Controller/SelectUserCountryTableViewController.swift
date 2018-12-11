//
//  SelectUserCountryTableViewController.swift
//  Shoghlana
//
//  Created by apple on 9/30/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import Alamofire

class SelectUserCountryTableViewController: UITableViewController {

    public var homeModel : HomeModel?
    var jobsList = [HomeJobsData]()
    var countriesList = [HomeCountriesData]()
    var positionsList = [HomePositionsData]()
    var levelsList = [HomeLevelsData]()
    
    var countryId:String = ""
    
    @IBOutlet var countriesTableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        getCountries()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return countriesList.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        cell.textLabel?.text = countriesList[indexPath.row].name ?? ""
        return cell
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        countryId = "\(countriesList[indexPath.row].id ?? 0)"
        updateUserCountry()
    }
    
    func getCountries(){
        //self.activityIndicatorView.startAnimating()
        HomeModelRequest().getHome(controller: self, apiTitle: "Home", view: self.view) { (data) in
            
            if (data.homeCountriesData?.count)! > 0 {
                
                //self.jobsTableView.reloadData()
                
                print("dataaaa: ",data)
                print("homeCountries count: ",data.homeCountriesData?.count)
                self.countriesList = data.homeCountriesData!
                print("cccc: ",self.countriesList.count)
                
                print("name[0]: ",self.countriesList[0].name)
                
                
                self.countriesTableView.reloadData()
                
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
    
    func updateUserCountry(){
        
        var userId:String = UserDefaults.standard.object(forKey: "userId") as? String ?? ""
        
        HomeModelRequest().updateUserCountry(controller: self, parameters: ["user_id":userId,"country_id":countryId], apiTitle: "Update Country", view: self.view) { (data) in

            print("update user country dataaaa: ",data)
            self.dismiss(animated: true, completion: nil)
            
        }
            
    }

}
