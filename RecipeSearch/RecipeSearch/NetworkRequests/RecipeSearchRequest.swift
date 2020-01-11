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
    
    required init(parms:[String:Any]) {
        url = appendSuffix(endpiont: EndPoints.SEARCH_RECIPE_URL)
        parameters = parms
        appendCommon(parms: &parameters)
    }

    func urlRequest() -> URLRequest  {

        return Alamofire.request(url, method: .get,
                                   parameters: parameters,
                                   encoding: URLEncoding.default,
                                   headers: ["Content-Type": "application/json"]).request!
        
    }

}
