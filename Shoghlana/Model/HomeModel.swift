import Foundation
import Alamofire
import MOLH

struct HomeModel : Codable {
    
	let homeJobsData : [HomeJobsData]?
	let homeCountriesData : [HomeCountriesData]?
	let homeLevelsData : [HomeLevelsData]?
	let homePositionsData : [HomePositionsData]?

	enum CodingKeys: String, CodingKey {

		case  homeJobsData = "jobs"
		case homeCountriesData = "countries"
		case homeLevelsData = "levels"
		case homePositionsData = "positions"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		homeJobsData = try values.decodeIfPresent([HomeJobsData].self, forKey: .homeJobsData)
		homeCountriesData = try values.decodeIfPresent([HomeCountriesData].self, forKey: .homeCountriesData)
		homeLevelsData = try values.decodeIfPresent([HomeLevelsData].self, forKey: .homeLevelsData)
		homePositionsData = try values.decodeIfPresent([HomePositionsData].self, forKey: .homePositionsData)
	}

}

struct HomeJobsData : Codable {
    let id : Int?
    let title : String?
    let logo : String?
    let company : String?
    let country : String?
    let city : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case logo = "logo"
        case company = "company"
        case country = "country"
        case city = "city"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        logo = try values.decodeIfPresent(String.self, forKey: .logo)
        company = try values.decodeIfPresent(String.self, forKey: .company)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        city = try values.decodeIfPresent(String.self, forKey: .city)
    }
    
}

struct HomeCountriesData : Codable {
    let id : Int?
    let name : String?
    let image : String?
    let count : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case image = "image"
        case count = "count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
    }
    
}

struct HomeLevelsData : Codable {
    let id : Int?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}

struct HomePositionsData : Codable {
    let id : Int?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}

class HomeModelRequest {
    
    func getHome(controller: UIViewController,apiTitle: String,view:UIView,completion: @escaping (_ homeModel : HomeModel) -> Void ){
        // Loading.instance.showLoading(view)
        var lang:String = "en"
        var userId:String = "0"
        if MOLHLanguage.isRTLLanguage(){
            lang = "ar"
        }else{
            lang = "en"
        }
        
        userId = UserDefaults.standard.object(forKey: "userId") as? String ?? "0"
        
        let homeURL:String = "http://www.shoglana.com/api/home/\(lang)/\(userId)"
        print("homeURL: ",homeURL)
        Alamofire.request(homeURL, method: .get, encoding: JSONEncoding.default).responseJSON(completionHandler:
            {
                ( response  ) in
                print(response)
                if validateResponse(controller: controller, controllerTitle: apiTitle, view: view, response: response){
                    
                    let decoder = JSONDecoder()
                    do {
                        let homeModel = try decoder.decode(HomeModel.self, from: response.data!)
                        completion(homeModel)
                    } catch {
                        displayAlert(title: apiTitle,message:"something_wrong".localized ,status: 0, forController: controller)
                    }
                }
                // Loading.instance.dismissLoading()
        })
    }
    
    
    func updateUserCountry(controller: UIViewController,parameters:[String:String],apiTitle: String,view:UIView,completion: @escaping (_ homeModel : HomeModel) -> Void ){
    
        let updateUserCountryURL:String = "http://www.shoglana.com/api/user/update_country"
        print("updateUserCountryURL: ",updateUserCountryURL)
        
        Alamofire.request(updateUserCountryURL, method: .post,parameters:parameters,encoding: JSONEncoding.default).responseJSON(completionHandler:
            {
                ( response  ) in
                print(response)
                if validateResponse(controller: controller, controllerTitle: apiTitle, view: view, response: response){
                    
                    let decoder = JSONDecoder()
                    do {
                        let homeModel = try decoder.decode(HomeModel.self, from: response.data!)
                        completion(homeModel)
                    } catch {
                        displayAlert(title: apiTitle,message:"something_wrong".localized ,status: 0, forController: controller)
                    }
                }
                // Loading.instance.dismissLoading()
        })
        
        
    }
    
    
}


