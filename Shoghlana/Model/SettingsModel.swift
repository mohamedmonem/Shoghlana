import Foundation
import Alamofire
import MOLH

struct SettingsModel : Codable {
	let settingData : SettingData?

	enum CodingKeys: String, CodingKey {

		case settingData = "setting"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		settingData = try values.decodeIfPresent(SettingData.self, forKey: .settingData)
	}

}

struct SettingData : Codable {
    let title : String?
    let text : String?
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        
        case title = "title"
        case text = "text"
        case image = "image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
    
}

class SettingModelRequest {
    
    func aboutApp(controller: UIViewController,apiTitle: String,view:UIView,completion: @escaping (_ settingModel : SettingsModel) -> Void ){
        // Loading.instance.showLoading(view)
        var lang:String = "en"
        if MOLHLanguage.isRTLLanguage(){
            lang = "ar"
        }else{
            lang = "en"
        }
        let aboutAppURL:String = "http://www.shoglana.com/api/about_us/\(lang)"
        print("aboutAppURL: ",aboutAppURL)
        Alamofire.request(aboutAppURL, method: .get, encoding: JSONEncoding.default).responseJSON(completionHandler:
            {
                ( response  ) in
                print(response)
                if validateResponse(controller: controller, controllerTitle: apiTitle, view: view, response: response){
                    
                    let decoder = JSONDecoder()
                    do {
                        let settingModel = try decoder.decode(SettingsModel.self, from: response.data!)
                        completion(settingModel)
                    } catch {
                        displayAlert(title: apiTitle,message:"something_wrong".localized ,status: 0, forController: controller)
                    }
                }
                // Loading.instance.dismissLoading()
        })
    }
    
}

