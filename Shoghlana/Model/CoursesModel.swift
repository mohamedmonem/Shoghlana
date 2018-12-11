
import Foundation
import Alamofire
import MOLH

struct CoursesModel : Codable {
	let coursesData: [CoursesData]?

	enum CodingKeys: String, CodingKey {

		case coursesData = "courses"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		coursesData = try values.decodeIfPresent([CoursesData].self, forKey: .coursesData)
	}

}

struct CoursesData : Codable {
    let id : Int?
    let title : String?
    let desc : String?
    let cover : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case desc = "desc"
        case cover = "cover"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        cover = try values.decodeIfPresent(String.self, forKey: .cover)
    }
    
}

class CoursesModelRequest {
    
    func myCourses(controller: UIViewController,apiTitle: String,view:UIView,completion: @escaping (_ coursesModel : CoursesModel) -> Void ){
        // Loading.instance.showLoading(view)
        var lang:String = "en"
        var userId:String = ""
        if MOLHLanguage.isRTLLanguage(){
            lang = "ar"
        }else{
            lang = "en"
        }
        
        userId = UserDefaults.standard.object(forKey: "userId") as? String ?? ""
        
        let myCoursesURL:String = "http://www.shoglana.com/api/my_courses/\(userId)"
        print("myCoursesURL: ",myCoursesURL)
        Alamofire.request(myCoursesURL, method: .get, encoding: JSONEncoding.default).responseJSON(completionHandler:
            {
                ( response  ) in
                print(response)
                if validateResponse(controller: controller, controllerTitle: apiTitle, view: view, response: response){
                    
                    let decoder = JSONDecoder()
                    do {
                        let myCoursesModel = try decoder.decode(CoursesModel.self, from: response.data!)
                        completion(myCoursesModel)
                    } catch {
                        displayAlert(title: apiTitle,message:"something_wrong".localized ,status: 0, forController: controller)
                    }
                }
                // Loading.instance.dismissLoading()
        })
    }
    
}
