//
//  CourseDetailsVC.swift
//  Shoghlana
//
//  Created by apple on 8/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import MOLH
import NVActivityIndicatorView

class CourseDetailsVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var imagesList = [SingleCourseImages?]()
    var courseList = [SingleCourseData]()

    var selectedCourse = ""
    
    var type:String = ""
    
    @IBOutlet weak var courseExplainationView: UIView!
    
    @IBOutlet weak var courseTitleLabel: UILabel!
    
    @IBOutlet weak var courseDescriptionTextView: UITextView!
    
    var youtubeURLArray:[String] = ["xJom7RUo_dQ","34JQxtOgYmY","jYqd7qPNTm0","3440XgqAU04"]
    
//    var courseImages:[String] = ["https://images.akhbarelyom.com/images/images/large/20180715221636408.jpg","https://s3.amazonaws.com/media.mediapost.com/dam/cropped/2017/05/02/shutterstock_517582159_kg0Jwqo.jpg","https://yourlistingexpert.com/wp-content/uploads/2018/01/google-budapest-office-2-760x428.jpg","https://static.independent.co.uk/s3fs-public/thumbnails/image/2016/02/19/15/googlechrome.jpg?w968"]
//
    @IBOutlet weak var courseDetailsCollectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    public var singleCourseModel : SingleCourseModel?
    
    var singleCourseList: [SingleCourseData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DesignableViews.viewBorderColor(view: courseExplainationView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 1)

        selectedCourse = UserDefaults.standard.object(forKey: "selectedCourse") as? String ?? ""
        print("Selected Course: ",selectedCourse)

        getCourseDetails()
        
        //print("singleCourseList count: ",singleCourseList?.count)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("imgs.count: ",imagesList.count)
        return self.imagesList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.imagesList[indexPath.row]?.type == "image" {
            
            
                    let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! CourseDetailsImagesCollectionViewCell
                    DesignableViews.viewBorderColor(view: imageCell.cellView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 1)
            
            var imageString = "http://shoglana.com/public/courses/\(imagesList[indexPath.row]?.file ?? "")"

            let finalImageString = imageString.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)

            print("finalImageString: ",finalImageString)

            //let logoURL = URL(string: (finalImageString) ?? "")


                    imageCell.setImage(url: finalImageString)
            
                    return imageCell
            
            
            
        }else{
        
            let youtubeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "youtubeCell", for: indexPath) as! YoutubeVideosCollectionViewCell
            DesignableViews.viewBorderColor(view: youtubeCell.cellView, cornerRadius: 8, borderColor: UIColor.lightGray.cgColor, borderWidth: 1)
            
            
            youtubeCell.setVideo(videoCode: youtubeURLArray[indexPath.row])
            
            return youtubeCell
            
        }
        
        
        
        
    }
    
    
    func getCourseDetails(){
        self.activityIndicatorView.startAnimating()
        SingleCourseModelRequest().getSingleCourse(controller: self, apiTitle: "Course", view: self.view) { (data) in
            
            self.courseList = [(data.singleCourseData)!]
            self.imagesList = (data.singleCourseData?.singleCourseImages)!
            
            
            
            print("images list count: ",self.imagesList.count ?? 0)
            
            self.courseDetailsCollectionView.reloadData()
            
//            for a in 0..<self.imagesList.count {
//
//            }
            
//            print("Images Type: ",self.imagesList[0].type ?? "")
            
            
            self.navigationItem.title = self.courseList[0].title
            self.courseDescriptionTextView.text = self.courseList[0].desc
            
//            print("count: ",data.singleCourseData?.count)
            
//            if (data.singleCourseData?.count)! > 0 {
//                self.singleCourseList = data.singleCourseData
//
//                self.courseDetailsCollectionView.reloadData()
//
//                self.navigationItem.title = data.singleCourseData?[0].title ?? ""
//
//                self.courseDescriptionTextView.text = data.singleCourseData?[0].desc ?? ""
//
//                print("desc :",data.singleCourseData?[0].desc ?? "")
//                print("title :",data.singleCourseData?[0].title ?? "")
//
//
//
//            }else{
//                self.activityIndicatorView.stopAnimating()
//                if MOLHLanguage.isRTLLanguage(){
//                    emptyLabel("لا يوجد دورات تدريبية", forController: self)
//                }else{
//                    emptyLabel("No training courses here", forController: self)
//                }
//            }
            
            print("Something >>>")
            self.activityIndicatorView.stopAnimating()
           
        }
        
    }


}
