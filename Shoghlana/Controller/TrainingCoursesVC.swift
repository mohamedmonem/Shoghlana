//
//  TrainingCoursesVC.swift
//  Shoghlana
//
//  Created by apple on 8/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import MOLH
import Alamofire
import NVActivityIndicatorView
import SDWebImage

class TrainingCoursesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var trainingCoursesTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    public var courseModel : CoursesModel?
    var courseList: [CoursesData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SharedHandler.sideMenus(ViewController: self)
        getMyCourses()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.courseList?.count ?? 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TrainingCoursesTableViewCell
        
        cell.delegate = self
        cell.selectionStyle = .none
        
        cell.cellCourseName.text = courseList?[indexPath.row].title ?? ""
        cell.cellCourseDescription.text = courseList?[indexPath.row].desc ?? ""
        
        
        
        var imageBaseURLString = "http://shoglana.com/public/courses/"
        var imageString = "\(imageBaseURLString)\(courseList?[indexPath.row].cover ?? "")"
        let finalImageString = imageString.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        
        let logoURL = URL(string: (finalImageString) ?? "")
        cell.cellCoursePhoto.sd_setImage(with: logoURL, placeholderImage: #imageLiteral(resourceName: "image_placeholder"))
        
        
        DesignableViews.viewBorderColor(view: cell.cellView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 1)
        
        self.activityIndicatorView.stopAnimating()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        
    }
    
    @objc func moreCellBtnClicked(cell : TrainingCoursesTableViewCell) {
        let ind = trainingCoursesTableView.indexPath(for: cell)
        
        do
        {
            
            print("More")
            print("ind",ind!)
            
         
            UserDefaults.standard.setValue("\(courseList?[(ind?.row)!].id ?? 0)", forKey: "selectedCourse")
            
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CourseDetailsVC")as! CourseDetailsVC
            self.navigationController?.pushViewController(vc, animated: true)
            
            
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
    
    func getMyCourses(){
        self.activityIndicatorView.startAnimating()
        CoursesModelRequest().myCourses(controller: self, apiTitle: "Courses", view: self.view) { (data) in
            
            if (data.coursesData?.count)! > 0 {
                self.courseList = data.coursesData
                self.trainingCoursesTableView.reloadData()
                
            }else{
                self.activityIndicatorView.stopAnimating()
                if MOLHLanguage.isRTLLanguage(){
                    emptyLabel("لا يوجد دورات تدريبية", forController: self)
                }else{
                    emptyLabel("No training courses here", forController: self)
                }
            }
        }
        
    }
    

}
