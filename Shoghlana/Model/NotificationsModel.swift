import Foundation
import Alamofire
import MOLH

struct NotificationsModel : Codable {
	let notificationsData : [NotificationsData]?

	enum CodingKeys: String, CodingKey {

		case notificationsData = "notifications"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		notificationsData = try values.decodeIfPresent([NotificationsData].self, forKey: .notificationsData)
	}

}

struct NotificationsData : Codable {
    let job_title : String?
    let job_id : Int?
    let title : String?
    let text : String?
    let since : String?
    
    enum CodingKeys: String, CodingKey {
        
        case job_title = "job_title"
        case job_id = "job_id"
        case title = "title"
        case text = "text"
        case since = "since"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        job_title = try values.decodeIfPresent(String.self, forKey: .job_title)
        job_id = try values.decodeIfPresent(Int.self, forKey: .job_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        since = try values.decodeIfPresent(String.self, forKey: .since)
    }
    
}

class NotificationsModelRequest {
    
    func getNotifications(controller: UIViewController,apiTitle: String,view:UIView,completion: @escaping (_ notificationsModel : NotificationsModel) -> Void ){
        // Loading.instance.showLoading(view)
        var lang:String = "en"
        var userId:String = ""
        if MOLHLanguage.isRTLLanguage(){
            lang = "ar"
        }else{
            lang = "en"
        }
        
        userId = UserDefaults.standard.object(forKey: "userId") as? String ?? ""
        
        let notificationsURL:String = "http://www.shoglana.com/api/my_notifications/\(lang)/\(userId)"
        print("notificationsURL: ",notificationsURL)
        Alamofire.request(notificationsURL, method: .get, encoding: JSONEncoding.default).responseJSON(completionHandler:
            {
                ( response  ) in
                print(response)
                if validateResponse(controller: controller, controllerTitle: apiTitle, view: view, response: response){
                    
                    let decoder = JSONDecoder()
                    do {
                        let notificationsModel = try decoder.decode(NotificationsModel.self, from: response.data!)
                        completion(notificationsModel)
                    } catch {
                        displayAlert(title: apiTitle,message:"something_wrong".localized ,status: 0, forController: controller)
                    }
                }
                // Loading.instance.dismissLoading()
        })
    }
    
}
