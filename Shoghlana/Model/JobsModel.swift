
import Foundation
import Alamofire
import MOLH

struct JobsModel : Codable {
	let jobsData : [JobsData]?

	enum CodingKeys: String, CodingKey {

		case jobsData = "jobs"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		jobsData = try values.decodeIfPresent([JobsData].self, forKey: .jobsData)
	}

}

struct JobsData : Codable {
    let id : Int?
    let user_id : Int?
    let job_id : Int?
    let title : String?
    let company : String?
    let logo : String?
    let country : String?
    let city : String?
    let since : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case user_id = "user_id"
        case job_id = "job_id"
        case title = "title"
        case company = "company"
        case logo = "logo"
        case country = "country"
        case city = "city"
        case since = "since"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        job_id = try values.decodeIfPresent(Int.self, forKey: .job_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        company = try values.decodeIfPresent(String.self, forKey: .company)
        logo = try values.decodeIfPresent(String.self, forKey: .logo)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        since = try values.decodeIfPresent(String.self, forKey: .since)
    }
    
}

class JobsModelRequest {
    
    func appliedJobs(controller: UIViewController,apiTitle: String,view:UIView,completion: @escaping (_ appliedJobsModel : JobsModel) -> Void ){
        // Loading.instance.showLoading(view)
        var userId:String = ""
        var lang:String = "en"
        if MOLHLanguage.isRTLLanguage(){
            lang = "ar"
        }else{
            lang = "en"
        }
        userId = UserDefaults.standard.object(forKey: "userId") as? String ?? ""
        print("userId: ",userId)
        let job_appliedURL:String = "http://www.shoglana.com/api/job_applied/\(lang)/\(userId)"
        print("job_appliedURL: ",job_appliedURL)
        Alamofire.request(job_appliedURL, method: .get, encoding: JSONEncoding.default).responseJSON(completionHandler:
            {
                ( response  ) in
                print(response)
                if validateResponse(controller: controller, controllerTitle: apiTitle, view: view, response: response){
                    
                    let decoder = JSONDecoder()
                    do {
                        let jobsModel = try decoder.decode(JobsModel.self, from: response.data!)
                        completion(jobsModel)
                    } catch {
                        displayAlert(title: apiTitle,message:"something_wrong".localized ,status: 0, forController: controller)
                    }
                }
                // Loading.instance.dismissLoading()
        })
    }
    
    func recommendedJobs(controller: UIViewController,apiTitle: String,view:UIView,completion: @escaping (_ recommendedJobsModel : JobsModel) -> Void ){
        // Loading.instance.showLoading(view)
        var userId:String = ""
        var lang:String = "en"
        if MOLHLanguage.isRTLLanguage(){
            lang = "ar"
        }else{
            lang = "en"
        }
        userId = UserDefaults.standard.object(forKey: "userId") as? String ?? ""
        print("userId: ",userId)
        let job_recommendedURL:String = "http://www.shoglana.com/api/job_suggested/\(lang)/\(userId)"
        print("job_recommendedURL: ",job_recommendedURL)
        Alamofire.request(job_recommendedURL, method: .get, encoding: JSONEncoding.default).responseJSON(completionHandler:
            {
                ( response  ) in
                print(response)
                if validateResponse(controller: controller, controllerTitle: apiTitle, view: view, response: response){
                    
                    let decoder = JSONDecoder()
                    do {
                        let jobsModel = try decoder.decode(JobsModel.self, from: response.data!)
                        completion(jobsModel)
                    } catch {
                        displayAlert(title: apiTitle,message:"something_wrong".localized ,status: 0, forController: controller)
                    }
                }
                // Loading.instance.dismissLoading()
        })
    }
    
    func favouriteJobs(controller: UIViewController,apiTitle: String,view:UIView,completion: @escaping (_ favouriteJobsModel : JobsModel) -> Void ){
        // Loading.instance.showLoading(view)
        var userId:String = ""
        var lang:String = "en"
        if MOLHLanguage.isRTLLanguage(){
            lang = "ar"
        }else{
            lang = "en"
        }
        userId = UserDefaults.standard.object(forKey: "userId") as? String ?? ""
        print("userId: ",userId)
        let job_favouriteURL:String = "http://www.shoglana.com/api/job_favorites/\(lang)/\(userId)"
        print("job_favouriteURL: ",job_favouriteURL)
        Alamofire.request(job_favouriteURL, method: .get, encoding: JSONEncoding.default).responseJSON(completionHandler:
            {
                ( response  ) in
                print(response)
                if validateResponse(controller: controller, controllerTitle: apiTitle, view: view, response: response){
                    
                    let decoder = JSONDecoder()
                    do {
                        let jobsModel = try decoder.decode(JobsModel.self, from: response.data!)
                        completion(jobsModel)
                    } catch {
                        displayAlert(title: apiTitle,message:"something_wrong".localized ,status: 0, forController: controller)
                    }
                }
                // Loading.instance.dismissLoading()
        })
    }
    
}
