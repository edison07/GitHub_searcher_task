//
//  APIService.swift
//  GitHub_Searcher
//
//  Created by edisonlin on 2022/3/4.
//

import Foundation
import Alamofire

class APIService {
    
    static let shared = APIService()
    
    func executeQuery(url:String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, encoding: ParameterEncoding = JSONEncoding.default, completion: @escaping (Result<Model, Error>) -> Void) {
        AF.request(url,method: method,parameters: parameters,encoding: encoding, headers: headers).responseData(completionHandler: {response in
            switch response.result{
            case .success(let res):
                if let code = response.response?.statusCode{
                    switch code {
                    case 200...299:
                        var linkStr: String?
                        if let link = response.response?.allHeaderFields["Link"] as? String {
                            linkStr = link.nextPagePath()
                        }
                        do {
                            let data = try JSONDecoder().decode(UserModel.self, from: res)
                            completion(.success(Model(nextPath: linkStr, data: data)))
                        } catch let error {
                            print(String(data: res, encoding: .utf8) ?? "nothing received")
                            completion(.failure(error))
                        }
                    default:
                        let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
