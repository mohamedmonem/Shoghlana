//import UIKit
//import JHSpinner
//
//class Loading: NSObject {
//    static let instance = Loading()
//    static var spinner:JHSpinnerView?
//    func dismissLoading(){
//        if Loading.spinner != nil{
//            Loading.spinner?.dismiss()
//        }
//    }
//    func showLoading(_ view:UIView){
//        if Loading.spinner != nil{
//            Loading.spinner?.dismiss()
//        }
//
//        Loading.spinner = JHSpinnerView.showOnView(view, spinnerColor: UIColor.init(hexString: "ECAD3C"), overlay: .fullScreen, overlayColor: UIColor.black.withAlphaComponent(0.6), fullCycleTime: 4.0, text: "جاري التحميل",textColor: UIColor.white)
//
//        view.addSubview(Loading.spinner!)
//    }
//    func updateProgressLoadingView(progress:Double){
//        Loading.spinner?.addCircleBorder(UIColor.init(hexString: "ECAD3C"), progress: CGFloat(progress / 100))
//    }
//    func showLoadingWithProgress(_ view:UIView){
//        if Loading.spinner != nil{
//            Loading.spinner?.dismiss()
//        }
//        Loading.spinner = JHSpinnerView.showOnView(view, spinnerColor: UIColor.init(hexString: "ECAD3C"), overlay: .fullScreen, overlayColor: UIColor.black.withAlphaComponent(0.6), fullCycleTime: 4.0, text: "جاري التحميل", textColor: UIColor.white)
//
//        view.addSubview(Loading.spinner!)
//    }
//}
