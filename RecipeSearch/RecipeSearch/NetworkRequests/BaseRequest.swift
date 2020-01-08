//
//  BaseRequest.swift
//  RecipeSearch
//
//  Created by Atef on 1/8/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation

protocol APIRequest {
    init(endpiont:String,parms:[String:Any])
}

extension APIRequest{
    func appendSuffix(endpiont:String) -> String {
        return EndPoints.BASE_URL+EndPoints.SEARCH_RECIPE_URL;
    }
    
    func appendCommon(parms:inout [String:Any]) {
        parms["app_id"]=APPLICATION_ID
        parms["app_key"]=APPLICATION_KEY

    }
}
