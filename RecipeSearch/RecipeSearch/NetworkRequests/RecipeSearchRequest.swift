//
//  RecipeSearchRequest.swift
//  RecipeSearch
//
//  Created by Atef on 1/9/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
import Alamofire


class RecipeSearchRequest: APIRequest {
    private var url:String="";
    private var parameters:[String: Any]=[:]
    
    required init(endpiont: String, parms:[String:Any]) {
        url = appendSuffix(endpiont: endpiont)
        parameters = parms
        appendCommon(parms: &parameters)
    }

    func urlRequest() -> DataRequest  {

        return Alamofire.request(url, method: .get,
                                   parameters: parameters,
                                   encoding: URLEncoding.default,
                                   headers: ["Content-Type": "application/json"])
        
    }

}
