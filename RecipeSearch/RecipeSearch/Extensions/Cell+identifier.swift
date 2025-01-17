//
//  Cell+identifier.swift
//  RecipeSearch
//
//  Created by Atef on 1/13/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
import UIKit
extension UITableViewCell{
    
    static var nib:UINib {
            return UINib(nibName: identifier, bundle: nil)
        }
        
        static var identifier: String {
            return String(describing: self)
        }
}
