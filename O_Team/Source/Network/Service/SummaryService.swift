import Foundation
import Alamofire

class ResponseSummary: Codable {
    let date: String
    let emotion: String
    let summary: String
}

class SummaryService {
    static func getSummary(_ name: String, _ completion: @escaping (ResponseSummary) -> Void) {
        let url = "http://tarae-env.eba-uepb7id2.ap-northeast-2.elasticbeanstalk.com:80/api/record/summary"
        let parameter: Parameters = ["name": name]
        
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default)
            .responseDecodable(of: ResponseSummary.self) { response in
                switch response.result {
                case .success(let model):
                    print(model)
                    completion(model)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
