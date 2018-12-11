

import Foundation
import Alamofire
import SWMessages
import AVFoundation
import AudioToolbox
import CoreLocation
import Photos


// MARK: - Get App Version
public func getVersion() -> String {
    if let AppVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString"){
        return AppVersion as! String
    }
    return "0.0"
    
}
public func convertToArabic(_ text : String)-> String {
    let numbersDictionary : Dictionary = ["0" : "۰","1" : "۱", "2" : "۲", "3" : "۳", "4" : "۴", "5" : "۵", "6" : "۶", "7" : "۷", "8" : "۸", "9" : "۹",".":","]
    var str : String = text
    
    for (key,value) in numbersDictionary {
        str =  str.replacingOccurrences(of: key, with: value)
    }
    
    return str
}
//########################## Alerts ##########################\\

// MARK: - Display normal alert
public func displayAlert(title: String, message:String,status:Int,forController controller:UIViewController){
    var alertTitle:String?
    var alertMessage:String?
    if message == "" {
        alertMessage = "error".localized
    }
    if title == "" {
        alertTitle = message
        alertMessage = ""
    }
    else{
        alertTitle = title
        alertMessage = message
    }
    var allertType : SWMessageNotificationType?
    if status == SUCCESS {
        allertType = .success
    }else if status == WARNING {
        allertType = .warning
    }else{
        allertType = .error
    }
    SWMessage.sharedInstance.showNotificationInViewController(controller, title: alertTitle!, subtitle: alertMessage!, type: allertType!)
}

// MARK: - Display alert with two buttons
public func displayAlertWithTwoButtons (status:Int,title: String, message:String, firstButtonTitle:String  , secondButtonTitle:String , forController controller:UIViewController,completion: @escaping (() -> ())){
    
    var allertType : SWMessageNotificationType?
    if status == SUCCESS {
        allertType = .success
    }else if status == WARNING {
        allertType = .warning
    }else{
        allertType = .error
    }
    SWMessage.sharedInstance.showNotificationInViewController(controller, title: title, subtitle: message, image: nil, type: allertType!, duration: .endless, callback: {
    }, buttonTitle: firstButtonTitle, buttonCallback: completion, atPosition: .top, canBeDismissedByUser: true, overrideStyle: nil)
}
func randomString(length: Int) -> String {
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(letters.length)
    var randomString = ""
    for _ in 0 ..< length {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }
    return randomString
}

// MARK: - Display alert for notification
public func displayAlertNotification(title: String, message:String, forController controller:UIViewController,completion: (() -> ())?){
    SWMessage.sharedInstance.showNotificationInViewController(controller, title: title, subtitle: message, image: #imageLiteral(resourceName: "no_ads.png"), type: .message, duration: .automatic, callback: {
    }, buttonTitle: "".localized, buttonCallback: completion, atPosition: .top, canBeDismissedByUser: true, overrideStyle: nil)
    
}

// MARK: - Display alert for notification
public func displayAlertNotificationUrgnet(title: String, message:String, forController controller:UIViewController,completion: (() -> ())?){
    SWMessage.sharedInstance.showNotificationInViewController(controller, title: title, subtitle: message, image: #imageLiteral(resourceName: "no_ads.png"), type: .warning, duration: .custom(30), callback: {
    }, buttonTitle: "".localized, buttonCallback: completion, atPosition: .top, canBeDismissedByUser: true, overrideStyle: nil)
    
}
// MARK: -
public func displayAlertWithAction (status:Int,title: String, message:String, firstButtonTitle:String  , forController controller:UIViewController,completion: @escaping (() -> ())){
    
    var allertType : SWMessageNotificationType?
    if status == SUCCESS {
        allertType = .success
    }else if status == WARNING {
        allertType = .warning
    }else{
        allertType = .error
    }
    SWMessage.sharedInstance.showNotificationInViewController(controller, title: title, subtitle: message, image: nil, type: allertType!, duration: .endless, callback: {
    }, buttonTitle: firstButtonTitle, buttonCallback: completion, atPosition: .top, canBeDismissedByUser: true, overrideStyle: nil)
    
}

// MARK: - Alert with sheet
public func displayAlertWithSheet(selectedBtn:UIButton ,  controller:UIViewController , array:[Int:String] , title:String , completion :@escaping (_ selected:Int)  -> () )
{
    let alert = UIAlertController(title: "", message: title, preferredStyle: .actionSheet)
    for ar in array
    {
        
        let action   = UIAlertAction(title:  ar.value, style: .default, handler: { (action) in
            selectedBtn.setTitle(ar.value, for: .normal)
            completion(ar.key)
            
        })
        
        alert.addAction(action)
    }
    
    
    let cancel = UIAlertAction(title: "cancel".localized, style: .destructive, handler: { ( action ) in
        
        
    })
    alert.addAction(cancel)
    
    alert.popoverPresentationController?.sourceView = selectedBtn
    alert.popoverPresentationController?.sourceRect = selectedBtn.bounds
    controller.present(alert, animated: true, completion: nil)
    
}

// MARK: - Alert for camera and gallery
public func showAlertForGalleryAndCamera( controller:UIViewController)
{
    
    displayAlertWithSheet(selectedBtn: UIButton(), controller: controller, array: [0:"camera".localized,1:"gallery".localized], title: "please_select_source".localized) { (type) in
        if type == 0 {
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = controller as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                imagePicker.allowsEditing = false
                controller.present(imagePicker, animated: true, completion: nil)
            }
        }else{
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = controller as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                imagePicker.allowsEditing = true
                controller.present(imagePicker, animated: true, completion: nil)
            }
        }
    }
}


//MARK: - dispatch queues

public func mainQueue(_ closure: @escaping ()->()){
    DispatchQueue.main.async(execute: closure)
}


//MARK: - active controller
// Returns the most recently presented UIViewController (visible)
public func getCurrentViewController() -> UIViewController? {
    
    // we must get the root UIViewController and iterate through presented views
    if let rootController = UIApplication.shared.keyWindow?.rootViewController {
        
        var currentController: UIViewController! = rootController
        
        // Each ViewController keeps track of the view it has presented, so we
        // can move from the head to the tail, which will always be the current view
        while( currentController.presentedViewController != nil ) {
            
            currentController = currentController.presentedViewController
        }
        return currentController
    }
    
    return nil
}


//MARK: - Localization and languages
public func localizedSitringFor(key:String)->String {
    return NSLocalizedString(key, comment: "")
}


//MARK: - Colors
public func hexStringToUIColor (hex:String , opacity : CGFloat) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    let cStringCount = cString.count
    if (cStringCount != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(opacity)
    )
}


// MARK: - Validation with effects

func animateValidationError(errorText : UILabel) {
    errorText.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    UIView.animate(withDuration: 0.2, animations: {
        errorText.transform = CGAffineTransform(scaleX: 1, y: 1)
    }, completion: { _ in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: DispatchTime.now().uptimeNanoseconds + (3 * NSEC_PER_SEC)), execute: {
            UIView.animate(withDuration: 0.2, animations: {
                errorText.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }, completion: { _ in
                errorText.removeFromSuperview()
            })
        })
    })
}


func isInstalled(appScheme:String) -> Bool{
    let appUrl = NSURL(string: appScheme)
    
    if UIApplication.shared.canOpenURL((appUrl! as NSURL) as URL)
    {
        return true
        
    } else {
        return false
    }
    
}


// Add image to nav bar

func addNavBarImage(_ viewController:UIViewController) {
    let navController = UINavigationController()
    let image = #imageLiteral(resourceName: "nav_image")
    let imageView = UIImageView(image: image)
    let bannerWidth = navController.navigationBar.frame.size.width / 2 - 8
    let bannerHeight = navController.navigationBar.frame.size.height / 2 - 8
    imageView.center = navController.navigationBar.center
    imageView.frame.size = CGSize(width: bannerWidth, height: bannerHeight)
    imageView.contentMode = .scaleAspectFit
    viewController.navigationItem.titleView = imageView
}

func fromStampToString(time: TimeInterval) -> String {
    
    let date = Date(timeIntervalSince1970: time)
    let dateFormatter = DateFormatter()
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy" //Specify your format that you want
    let strDate = dateFormatter.string(from: date)
    return strDate
}

// add image for empty lists
func emptyImage(image:String, view:UIView,width:Int,height:Int){
    let w = view.bounds.width
    let h = view.bounds.height
    let i = UIImage(named:image)
    let imageView = UIImageView(image: i)
    imageView.frame = CGRect(x: 0, y: Int(h / 2), width: width, height: height)
    imageView.center = CGPoint(x: w / 2, y: h / 2)
    imageView.tag = 2000000
    animate(imageView: imageView)
    view.addSubview(imageView)
}


// add image for empty lists
func removeImage(forController controller:UIViewController){
    if let viewWithTag = controller.view.viewWithTag(2000000) {
        viewWithTag.removeFromSuperview()
    }
}
public func emptyLabel(_ message:String,forController controller:UIViewController){
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    removeEmptyLabel(forController: controller)
    let  label = UILabel(frame: CGRect(x:0 , y: h / 2, width: w, height: 30))
    label.text = message
    label.center = CGPoint(x: w / 2, y: h / 2)
    label.textAlignment = .center
    label.textColor = hexStringToUIColor(hex: "6E6E6E", opacity: 1)
    label.font = UIFont(name: "cairo", size: 20)
    label.tag = 505050
    controller.self.view.addSubview(label)
}
public func removeEmptyLabel(forController controller:UIViewController){
    
    if let label = controller.view.viewWithTag(505050){
        label.removeFromSuperview()
    }
    
}

//play system sound method
func playSystemSound(id:SystemSoundID){
    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    AudioServicesPlayAlertSound(id)
}


// add animation for ImageView
func animate(imageView:UIImageView) {
    // animate the imageView
    let rotate = CGAffineTransform(rotationAngle: -0.2)
    let stretchAndRotate = rotate.scaledBy(x: 0.5, y: 0.5)
    imageView.transform = stretchAndRotate
    imageView.alpha = 0.5
    UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping:  0.45, initialSpringVelocity: 10.0, options:[.curveEaseOut], animations: {
        imageView.alpha = 1.0
        let rotate = CGAffineTransform(rotationAngle: 0.0)
        let stretchAndRotate = rotate.scaledBy(x: 1.0, y: 1.0)
        imageView.transform = stretchAndRotate
        
    }, completion: nil)
}

func getAssetThumbnail(asset: PHAsset) -> UIImage {
    let manager = PHImageManager.default()
    let option = PHImageRequestOptions()
    var thumbnail = UIImage()
    option.isSynchronous = true
    manager.requestImage(for: asset, targetSize: CGSize(width: 500 , height: 500), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
        thumbnail = result!
    })
    return thumbnail
}

func getNameToImage(_ fullName: String)-> String{
    let fullNameArr = fullName.split{$0 == " "}.map(String.init)
    
    if fullNameArr.count > 1 {
        return("\(fullNameArr[0].first!)".uppercased() + "\(fullNameArr[1].first!)".uppercased())
    }else if fullNameArr.count == 0  {
        return "\(fullNameArr[0].first ?? "A")".uppercased()
    }else{
        return "AMAR"
    }
}



// MARK: - get location address from coordinates

func getLocationFromCoor(coordinate:CLLocation,completion :@escaping (_ address: String) -> ()){
    let geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(coordinate) { (placemarksArray, error) in
        
        if (placemarksArray?.count)! > 0 {
            let placemark = placemarksArray?.first
            var no  = ""
            var bai = ""
            var st = ""
            if let number = placemark!.subThoroughfare
            {
                no = number
            }
            if let bairro = placemark!.subLocality
            {
                bai = bairro
            }
            if let street = placemark!.thoroughfare
            {
                st = street
            }
            let address = st + " " + no + " " + bai
            completion(address)
        }
    }
}

public func removeHint(){
    let superview = UIApplication.shared.windows.first!
    if let viewWithTag = superview.viewWithTag(202020) {
        viewWithTag.removeFromSuperview()
    }
}
// MARK: - Motion Effect
func applyMotionEffect (toView view:UIView?, magnitude:Float) {
    let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
    xMotion.minimumRelativeValue = -magnitude
    xMotion.maximumRelativeValue = magnitude
    
    let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
    yMotion.minimumRelativeValue = -magnitude
    yMotion.maximumRelativeValue = magnitude
    
    let group = UIMotionEffectGroup()
    group.motionEffects = [xMotion, yMotion]
    
    guard view != nil else {
        return
    }
    view!.addMotionEffect(group)
}

public func validateResponse (controller: UIViewController,controllerTitle: String,view:UIView, response:DataResponse<Any>) ->Bool{
    switch response.result {
    case .success:
        switch response.response?.statusCode {
        case SUCCESS?:
            return true
        case CREATED?:
            return true
        case UNAUTHENTICATED?:
            
            displayAlert(title: controllerTitle,message: "مستخدم غير صحيح",status: 0, forController: controller)
            return false
        case UNSUBSCRIBED?:
            displayAlert(title: "عذرا",message: "يجب ان يتم تفعيل الحساب قبل ان تقوم بإضافة إعلان" ,status: WARNING, forController: controller)
            return false
        case INVALID_DATA?:
            displayAlert(title: controllerTitle,message:"بيانات غير صحيحة",status: 0, forController: controller)
            return false
        default:
            return false
        }
    case .failure:
        displayAlert(title: controllerTitle,message:"حدث خطأ ما" + "," + "تأكد من الاتصال بالشبكة" ,status: 0, forController: controller)
        
        return false
    }
}

