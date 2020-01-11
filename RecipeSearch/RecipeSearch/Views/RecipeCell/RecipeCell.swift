//
//  RecipeCell.swift
//  RecipeSearch
//
//  Created by Atef on 1/8/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var item: Hit? {
          didSet {
            guard  let item = item else {
                  return
              }
              //set data here
          }
      }
      
      static var nib:UINib {
          return UINib(nibName: identifier, bundle: nil)
      }
      
      static var identifier: String {
          return String(describing: self)
      }
    
}
