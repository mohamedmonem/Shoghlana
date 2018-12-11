import Foundation
import Alamofire
import MOLH

struct SupportMessagesModel : Codable {
	let supportMessagesData : [SupportMessagesData]?

	enum CodingKeys: String, CodingKey {

		case supportMessagesData = "messages"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		supportMessagesData = try values.decodeIfPresent([SupportMessagesData].self, forKey: .supportMessagesData)
	}

}

struct SupportMessagesData : Codable {
    let id : Int?
    let sender_id : Int?
    let target_id : Int?
    let text : String?
    let file : String?
    let since : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case sender_id = "sender_id"
        case target_id = "target_id"
        case text = "text"
        case file = "file"
        case since = "since"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        sender_id = try values.decodeIfPresent(Int.self, forKey: .sender_id)
        target_id = try values.decodeIfPresent(Int.self, forKey: .target_id)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        file = try values.decodeIfPresent(String.self, forKey: .file)
        since = try values.decodeIfPresent(String.self, forKey: .since)
    }
    
}

class SupportMessagesModelRequest {
    
    func getSupportMessages(parameters:[String:String], controller: UIViewController,apiTitle: String,view:UIView,completion: @escaping (_ supportMessagesModel : SupportMessagesModel) -> Void ){
        // Loading.instance.showLoading(view)
        var lang:String = "en"
        var userId:String = ""
        if MOLHLanguage.isRTLLanguage(){
            lang = "ar"
        }else{
            lang = "en"
        }
        
        userId = UserDefaults.standard.object(forKey: "userId") as? String ?? ""
        
        let supportMessagessURL:String = "http://www.shoglana.com/api/get_support_messages/ar"
        print("supportMessagessURL: ",supportMessagessURL)
        Alamofire.request(supportMessagessURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler:
            {
                ( response  ) in
                print(response)
                if validateResponse(controller: controller, controllerTitle: apiTitle, view: view, response: response){
                    
                    let decoder = JSONDecoder()
                    do {
                        let supportMessagesModel = try decoder.decode(SupportMessagesModel.self, from: response.data!)
                        completion(supportMessagesModel)
                    } catch {
                        displayAlert(title: apiTitle,message:"something_wrong".localized ,status: 0, forController: controller)
                    }
                }
                // Loading.instance.dismissLoading()
        })
    }
    
}
