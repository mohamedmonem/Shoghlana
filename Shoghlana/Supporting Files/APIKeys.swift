
import UIKit
import Alamofire
import MOLH

class APIKeys: NSObject {
    
    // get the language of the app
    internal static let deviceLanguage =  Bundle.main.preferredLocalizations.first
    
    // create http headers to send it with all requests
    
//    var AuthorizedHeader :HTTPHeaders =
//        [
//            "Authorization" : "Bearer \(UserDefaults().string(forKey: "token") ?? "")",
//            "Id" : String(UserDefaults().integer(forKey: "id")) ,
//            "Content-Type" : "application/json" ,
//            "Accept": "application/json" ,
//            "x-api-key" : X_API_KEY,
//            "Accept-Language" : "En"
//    ]
    
//    override init() {
//        if APIKeys.deviceLanguage == "ar"
//        {
//            self.AuthorizedHeader["Accept-Language"] = "Ar"
//        }
//        else{
//            self.AuthorizedHeader["Accept-Language"] = "En"
//        }
//    }
    
    //########################## API Routes ##########################\\
    
    var userId = UserDefaults.standard.object(forKey: "userId") as? String ?? ""
    var lang = "en"
    
    
    var login:String  { return BASE_URL + "login" }
    var register:String  { return BASE_URL + "register" }
    //var job_applied:String  { return BASE_URL + "job_applied/\(userId)" }
    var job_favorites:String  { return BASE_URL + "job_favorites" }
    var job_suggested:String  { return BASE_URL + "job_suggested" }
    
    
    
}
