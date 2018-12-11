//
//  ForgetPasswordConfirmationVC.swift
//  Shoghlana
//
//  Created by apple on 7/27/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class FPConfirmationVC: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 1
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }

}
