//
//  RecipeCell.swift
//  RecipeSearch
//
//  Created by Atef on 1/8/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import UIKit
import Kingfisher

class RecipeCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWith(item: Hit) {
        recipeImageView.kf.setImage(with: URL(string:item.recipe.image ), placeholder: UIImage(named: "default"))
        titleLabel.text = item.recipe.label
        sourceLabel.text = item.recipe.source
        healthLabel.text = item.recipe.healthLabels.joined(separator: "\n")
      }
    
    
}
