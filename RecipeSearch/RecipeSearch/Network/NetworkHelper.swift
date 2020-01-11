//
//  NetworkHelper.swift
//  RecipeSearch
//
//  Created by Atef on 1/8/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
import Alamofire

class NetworkHelper {
    static let shared = NetworkHelper()
    
    private init(){}
    
    func getData(urlRequest:APIRequest,
                 success:@escaping (Data) -> Void,
                 failure:@escaping (Error)->Void){
        
            Alamofire.request(urlRequest.urlRequest()).validate().responseData{ (response) in
                switch response.result{
                case .failure(let e):
                    failure(e)
                case .success(let data):
                    success(data)
                    /*
                     later i'll convert it to generic
                    let jsonDecoder = JSONDecoder()
                    if let responseModel = try? jsonDecoder.decode(T.self, from: data) {
                        seal.fulfill(data)
                    }else{
                        seal.reject(NSError(domain: "", code: response.response?.statusCode ?? 400, userInfo: nil))
                    }*/
                }
            }
        
    }
    
}
