import Foundation
import Alamofire

class ListresponseModel: Codable {
    let answer: String
    let contents: String
}

class ListService {
    static func getList(_ completion: @escaping ([ListresponseModel]) -> Void) {
        guard /* let userName = */ UserDefaults.standard.string(forKey: "key") != nil else { return }
        let urlStr = "http://tarae-env.eba-uepb7id2.ap-northeast-2.elasticbeanstalk.com:80/api/record/list?name=도도"
        let encodedStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)
        
        AF.request(url!)
            .responseDecodable(of: [ListresponseModel].self) { response in
                switch response.result {
                case .success(let dataArray):
                    completion(dataArray)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
