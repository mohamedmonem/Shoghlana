//
//  CollectionViewCell.swift
//  Shoghlana
//
//  Created by apple on 8/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage


class YoutubeVideosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        // Configure the view for the selected state
//    }
    func setVideo(videoCode: String) {
        webView.loadRequest(URLRequest(url: URL(string: "\(URLHandler.youtubeBaseUrl)\(videoCode)")!))
    }
    
}

class CourseDetailsImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }
    func setImage(url : String) {
        DispatchQueue.main.async {
            self.cellImage.sd_setImage(with: URL(string: url))
        }
    }
    
}

class HomeCountriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var jobsCount: UILabel!
    @IBOutlet weak var cellView: UIView!
    
}

class HomeJobsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var jobLogo: UIImageView!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyLocation: UILabel!
    @IBOutlet weak var cellView: UIView!
    
}
