import Foundation
import Alamofire

struct DiaryMonthly: Codable {
    let date: String
    let emotion: String
}

struct Diary: Codable {
    let contents: String
    let date: String
    let emotion: String
}

typealias DiaryMonthlyResponse = [DiaryMonthly]

struct DiaryData: Codable {
    let anniversaryDiary: Diary
    let positiveDiary: Diary
    let yearAgoDiary: Diary
}

struct DiaryMonthResponse: Codable {
    let date: String
    let emotion: String
}

class CalendarService {
    func getHomeVideoList(userName: String, today: String, onCompletion: @escaping (DiaryData?) -> Void) {
        let url = "http://tarae-env.eba-uepb7id2.ap-northeast-2.elasticbeanstalk.com:80/api/diary?userName=\(userName)&today=\(today)"
        guard let transfromURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        AF.request(transfromURL,
                   method: .get,
                   parameters: nil,
                   headers: nil)
        .responseDecodable(of: DiaryData.self) { response in
                switch response.result {
                case .success(let response):
                   onCompletion(response)
                case .failure(let error):
                    print("first error: \(error.localizedDescription)")
                    onCompletion(nil)
                }
            }
    }
    
    func getMonthEmotion(yearMonth: String, userName: String, onCompletion: @escaping (DiaryMonthlyResponse?) -> Void) {
        let url = "http://tarae-env.eba-uepb7id2.ap-northeast-2.elasticbeanstalk.com:80/api/diary/monthly?yearMonth=\(yearMonth)&userName=\(userName)"
        guard let transfromURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        // let parameter: Parameters = ["yearMonth" : yearMonth, "userName" : userName]
        AF.request(transfromURL,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil)
            .responseDecodable(of: DiaryMonthlyResponse.self) { response in
                print(response.debugDescription)
                switch response.result {
                case .success(let response):
                    print(response)
                    onCompletion(response)
                case .failure(let error):
                    print("monthlyEmotion error: \(error.localizedDescription)")
                    onCompletion(nil)
                }
            }
    }
}
