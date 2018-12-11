
import Foundation
import Alamofire

struct SingleCourseModel : Codable {
	let singleCourseData : SingleCourseData?

	enum CodingKeys: String, CodingKey {

		case singleCourseData = "course"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		singleCourseData = try values.decodeIfPresent(SingleCourseData.self, forKey: .singleCourseData)
	}

}
struct SingleCourseImages : Codable {
    let type : String?
    let file : String?
    
    enum CodingKeys: String, CodingKey {
        
        case type = "type"
        case file = "file"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        file = try values.decodeIfPresent(String.self, forKey: .file)
    }
    
}

struct SingleCourseData : Codable {
    let id : Int?
    let user_id : Int?
    let title : String?
    let desc : String?
    let singleCourseImages : [SingleCourseImages]?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case user_id = "user_id"
        case title = "title"
        case desc = "desc"
        case singleCourseImages = "images"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        singleCourseImages = try values.decodeIfPresent([SingleCourseImages].self, forKey: .singleCourseImages)
    }
    
}

class SingleCourseModelRequest {
    
    func getSingleCourse(controller: UIViewController,apiTitle: String,view:UIView,completion: @escaping (_ singleCourseModel : SingleCourseModel) -> Void ){
        // Loading.instance.showLoading(view)

        
       var courseId = UserDefaults.standard.object(forKey: "selectedCourse") as? String ?? ""
        
        let singleCourseURL:String = "http://www.shoglana.com/api/course/\(courseId)/show"
        print("singleCourseURL: ",singleCourseURL)
        Alamofire.request(singleCourseURL, method: .get, encoding: JSONEncoding.default).responseJSON(completionHandler:
            {
                ( response  ) in
                print(response)
                if validateResponse(controller: controller, controllerTitle: apiTitle, view: view, response: response){
                    
                    let decoder = JSONDecoder()
                    do {
                        let singleCourseModel = try decoder.decode(SingleCourseModel.self, from: response.data!)
                        completion(singleCourseModel)
                    } catch {
                        displayAlert(title: apiTitle,message:"something_wrong".localized ,status: 0, forController: controller)
                    }
                }
                // Loading.instance.dismissLoading()
        })
    }
    
}
