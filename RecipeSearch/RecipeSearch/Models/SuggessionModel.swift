//
//  SuggessionModel.swift
//  RecipeSearch
//
//  Created by Atef on 1/11/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
import RealmSwift

class SuggessionModel:Object {
    @objc dynamic var suggestion = ""
    @objc dynamic var dateCreated = Date(timeIntervalSince1970: 1)
}

