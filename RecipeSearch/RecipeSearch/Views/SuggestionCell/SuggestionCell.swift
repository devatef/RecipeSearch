//
//  SuggestionCell.swift
//  RecipeSearch
//
//  Created by Atef on 1/13/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import UIKit

class SuggestionCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
 
    func configureWith(item: SuggessionModel) {
        self.textLabel?.text = item.suggestion
         }
}
