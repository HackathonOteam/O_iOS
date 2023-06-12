import Foundation
import Alamofire

class RecordingResponseModel: Codable {
    let answer: String
}

class DiaryService {
    static func createDiary() {
        guard let name = UserDefaults.standard.string(forKey: "key") else { return }
        let url = "http://tarae-env.eba-uepb7id2.ap-northeast-2.elasticbeanstalk.com:80/api/record/diary"
        let paramter: Parameters = ["name":name]
        
        AF.request(url, method: .post, parameters: paramter, encoding: JSONEncoding.default)
            .responseString() { response in
                switch response.result {
                case .success(let string):
                    print(string)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    static func createRecord(_ text: String, _ completion: @escaping (RecordingResponseModel) -> Void) {
        guard let name = UserDefaults.standard.string(forKey: "key") else { return }
        let url = "http://tarae-env.eba-uepb7id2.ap-northeast-2.elasticbeanstalk.com:80/api/record"
        let paramter: Parameters = ["name":name,
                                    "content":text]
        
        AF.request(url, method: .post, parameters: paramter, encoding: JSONEncoding.default)
            .responseDecodable(of:RecordingResponseModel.self) { response in
                switch response.result {
                case .success(let model):
                    completion(model)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
