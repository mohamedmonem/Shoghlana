//
//  TableViewCell.swift
//  Shoghlana
//
//  Created by apple on 8/5/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class myJobsTableViewCell: UITableViewCell {
    @IBOutlet weak var cellJobName: UILabel!
    @IBOutlet weak var cellCompanyName: UILabel!
    @IBOutlet weak var cellCompanyLocation: UILabel!
    @IBOutlet weak var cellJobDate: UILabel!
    @IBOutlet weak var cellJobPhoto: UIImageView!
    @IBOutlet weak var cellView: UIView!
}


class jobApplicantsTableViewCell: UITableViewCell {
    
    var delegate: JobApplicantsVC?
    
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDate: UILabel!
    @IBOutlet weak var cellShowProfile: UIButton!
    @IBOutlet weak var cellAccept: UIButton!
    @IBOutlet weak var cellReject: UIButton!
    @IBOutlet weak var cellProfilePic: UIImageView!
    @IBOutlet weak var cellView: UIView!
    
    @IBAction func viewProfileCellBtnClicked(_ sender: Any) {
        delegate?.viewProfileCellBtnClicked(cell: self)
    }
    
    
    @IBAction func acceptCellBtnClicked(_ sender: Any) {
       delegate?.acceptCellBtnClicked(cell: self)
    }
    
    @IBAction func rejectCellBtnClicked(_ sender: Any) {
        delegate?.rejectCellBtnClicked(cell: self)
    }
    
    
}

class TrainingCoursesTableViewCell: UITableViewCell {
    
    var delegate:TrainingCoursesVC?
    
    @IBOutlet weak var cellCourseName: UILabel!
    @IBOutlet weak var cellCourseDescription: UITextView!
    @IBOutlet weak var cellCoursePhoto: UIImageView!
    @IBOutlet weak var cellMore: UIButton!
    @IBOutlet weak var cellView: UIView!
    
    
    @IBAction func moreCellBtnClicked(_ sender: Any) {
        
        delegate?.moreCellBtnClicked(cell: self)
        
    }
    
}

class PackagesTableViewCell: UITableViewCell {
    
    var delegate:PackagesVC?
    
    @IBOutlet weak var cellDuration: UILabel!
    @IBOutlet weak var cellPrice: UILabel!
    @IBOutlet weak var cellRegister: UIButton!
    @IBOutlet weak var cellView: UIView!
    
    @IBAction func registerCellBtnClicked(_ sender: Any) {
        
        delegate?.registerCellBtnClicked(cell: self)
        
    }
    
    
}

class ContactAppAdminTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellTime: UILabel!
    @IBOutlet weak var cellMessage: UITextView!
    @IBOutlet weak var cellImage: UIImageView!
    
    
}

class ProfileDetailsMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellJob: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
}

class NotificationTableViewCell: UITableViewCell {
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationText: UITextView!
    @IBOutlet weak var notificationDate: UILabel!
    @IBOutlet weak var notificationView: UIView!
}

class LoginTableViewCell: UITableViewCell {
@IBOutlet weak var loginOrLogoutLabel: UILabel!
}


