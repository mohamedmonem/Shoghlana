
import Foundation
import Alamofire
import MOLH

struct SingleJobModel : Codable {
    let singleJobData : SingleJobData?
    
    enum CodingKeys: String, CodingKey {
        
        case singleJobData = "jobs"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        singleJobData = try values.decodeIfPresent(SingleJobData.self, forKey: .singleJobData)
    }
    
}

struct SingleJobData : Codable {
    let id : Int?
    let user_id : Int?
    let level_id : String?
    let country_id : String?
    let city_id : String?
    let email : String?
    let title : String?
    let desc : String?
    let skills : [String]?
    let details : String?
    let position : String?
    let company : String?
    let logo : String?
    let file : String?
    let created_at : String?
    let updated_at : String?
    let is_applied : Bool?
    let is_favorite : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case user_id = "user_id"
        case level_id = "level_id"
        case country_id = "country_id"
        case city_id = "city_id"
        case email = "email"
        case title = "title"
        case desc = "desc"
        case skills = "skills"
        case details = "details"
        case position = "position"
        case company = "company"
        case logo = "logo"
        case file = "file"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case is_applied = "is_applied"
        case is_favorite = "is_favorite"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        level_id = try values.decodeIfPresent(String.self, forKey: .level_id)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        skills = try values.decodeIfPresent([String].self, forKey: .skills)
        details = try values.decodeIfPresent(String.self, forKey: .details)
        position = try values.decodeIfPresent(String.self, forKey: .position)
        company = try values.decodeIfPresent(String.self, forKey: .company)
        logo = try values.decodeIfPresent(String.self, forKey: .logo)
        file = try values.decodeIfPresent(String.self, forKey: .file)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        is_applied = try values.decodeIfPresent(Bool.self, forKey: .is_applied)
        is_favorite = try values.decodeIfPresent(Bool.self, forKey: .is_favorite)
    }
    
}

class SingleJobModelRequest {
    
    func singleJob(controller: UIViewController,apiTitle: String,view:UIView,completion: @escaping (_ singleJobModel : SingleJobModel) -> Void ){
        // Loading.instance.showLoading(view)
        var lang:String = "en"
        var userId:String = ""
        var jobId:String = ""
        if MOLHLanguage.isRTLLanguage(){
            lang = "ar"
        }else{
            lang = "en"
        }
        
        userId = UserDefaults.standard.object(forKey: "userId") as? String ?? ""
        jobId = UserDefaults.standard.object(forKey: "selectedJob") as? String ?? ""
        
        let singleJobURL:String = "http://www.shoglana.com/api/job_show/\(lang)/\(jobId)/\(userId)"
        print("singleJobURL: ",singleJobURL)
        Alamofire.request(singleJobURL, method: .get, encoding: JSONEncoding.default).responseJSON(completionHandler:
            {
                ( response  ) in
                print(response)
                if validateResponse(controller: controller, controllerTitle: apiTitle, view: view, response: response){
                    
                    let decoder = JSONDecoder()
                    do {
                        let singleJobModel = try decoder.decode(SingleJobModel.self, from: response.data!)
                        completion(singleJobModel)
                    } catch {
                        displayAlert(title: apiTitle,message:"something_wrong".localized ,status: 0, forController: controller)
                    }
                }
                // Loading.instance.dismissLoading()
        })
    }
    
}
