//
//  RecipeRepo.swift
//  RecipeSearch
//
//  Created by Atef on 1/10/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
import PromiseKit

class RecipeRepo {
    
    func searchFor(keyword:String,page:Int) -> Promise<RecipeModel> {
        return Promise{ seal in
            NetworkHelper.shared.getData(urlRequest: RecipeSearchRequest(parms: ["q" : keyword,"from":page]),
                                         success: {data in
                                            let str = String(decoding: data, as: UTF8.self)
                                            print(str)
                                            let jsonDecoder = JSONDecoder()
                                            if let model = try? jsonDecoder.decode(RecipeModel.self, from: data) {
                                                seal.fulfill(model)
                                            }else if let model = try? jsonDecoder.decode(LimitsError.self, from: data)
                                            {
                                                seal.reject(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:model.message]))
                                            }
                                            else{
                                                seal.reject(NSError(domain: "", code: -1, userInfo: nil))
                                            }
                                       },
                                         failure: {error in
                                            seal.reject(error)
                                            
                                       }
            )
            
              }
        
    }
    
    func getSuggession() -> [SuggessionModel] {
        return []
    }
}
