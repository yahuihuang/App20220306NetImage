//
//  APIModel.swift
//  App20220306NetImage
//
//  Created by grace on 2022/3/6.
//

import UIKit
import Alamofire

class APIModel {
    static var share = APIModel()
    private var apiURL = "https://randomuser.me/api"
    
    private init() {
        
    }
    
    func queryRandomUserAlamofire(completion: @escaping(_ data: Any?, _ respError: Error?)->())-> () {
        let url = apiURL
        DispatchQueue.global().async {
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: nil).responseJSON { (response) in
                DispatchQueue.main.async {
                execute: do {
                        switch response.result {
                        case .success(_):
                            return completion(response.data, nil)
                        case .failure(let error):
                            return completion(nil, error)
                        }
                    }
                }
            }
        }
    }
}
