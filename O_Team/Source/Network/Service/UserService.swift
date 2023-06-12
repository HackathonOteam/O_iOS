import Foundation
import Alamofire

struct UserRequest: Codable {
    let userName: String
    var parameters: [String: Any] {
         return [
             "userName": userName,
             // +
         ]
     }
}

struct UserResponse: Decodable {
    let name: String?
}

class UserService {
    func PostJoin(userName: String, onCompletion: @escaping (UserResponse) -> Void) {
        let url = "http://tarae-env.eba-uepb7id2.ap-northeast-2.elasticbeanstalk.com:80/api/user"
        let parameter: Parameters = ["name": userName]
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: UserResponse.self) { response in
                print(response.debugDescription)
                switch response.result {
                case .success(let data):
                    print("Success")
                    print(data)
                    onCompletion(data)
                case .failure(let error):
                    print("login Error")
                    print("Error: \(error)")
                }
            }
    }
}
