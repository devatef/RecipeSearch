//
//  BaseRequest.swift
//  RecipeSearch
//
//  Created by Atef on 1/8/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation

protocol APIRequest {
    init(endpiont:String,parms:Dictionary<String,Any>)
}
