
import Foundation
import Alamofire

struct UserModel : Codable {
	let status : String?
	let msg : String?
	let userInfo : UserInfo?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case msg = "msg"
		case userInfo = "info"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		msg = try values.decodeIfPresent(String.self, forKey: .msg)
		userInfo = try values.decodeIfPresent(UserInfo.self, forKey: .userInfo)
	}

}

struct UserInfo : Codable {
    let id : Int?
    let type : String?
    let name : String?
    let title : String?
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case type = "type"
        case name = "name"
        case title = "title"
        case image = "image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
    
}

class UserModelRequest {
    
    func Login(parameters:[String:String],controller: UIViewController,apiTitle: String,view:UIView,completion: @escaping (_ loginModel : UserModel) -> Void ){
       // Loading.instance.showLoading(view)
        
        Alamofire.request(APIKeys().login, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler:
            {
                ( response  ) in
                print(response)
                if validateResponse(controller: controller, controllerTitle: apiTitle, view: view, response: response){
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let userModel = try decoder.decode(UserModel.self, from: response.data!)
                        completion(userModel)
                    } catch {
                        displayAlert(title: apiTitle,message:"something_wrong".localized ,status: 0, forController: controller)
                    }
                }
               // Loading.instance.dismissLoading()
        })
        
        
    }
    
    func Register(parameters:[String:String],controller: UIViewController,apiTitle: String,view:UIView,completion: @escaping (_ registerModel : UserModel) -> Void ){
        // Loading.instance.showLoading(view)
        
        Alamofire.request(APIKeys().register, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler:
            {
                ( response  ) in
                print(response)
                if validateResponse(controller: controller, controllerTitle: apiTitle, view: view, response: response){
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let userModel = try decoder.decode(UserModel.self, from: response.data!)
                        completion(userModel)
                    } catch {
                        displayAlert(title: apiTitle,message:"something_wrong".localized ,status: 0, forController: controller)
                    }
                }
                // Loading.instance.dismissLoading()
        })
        
        
    }
    
}

