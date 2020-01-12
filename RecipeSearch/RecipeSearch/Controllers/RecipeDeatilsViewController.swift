//
//  RecipeDeatilsViewController.swift
//  RecipeSearch
//
//  Created by Atef on 1/8/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import UIKit
import SafariServices
import Kingfisher

class RecipeDeatilsViewController: UIViewController {
      @IBOutlet weak var titleLabel: UILabel!
      @IBOutlet weak var ingridientsLabel: UILabel!
      @IBOutlet weak var linkLabel: UILabel!
      @IBOutlet weak var recipeImageView: UIImageView!
      @IBOutlet weak var ingreideintsHeightConstraints: NSLayoutConstraint!

    var recipeModel:Hit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeImageView.kf.setImage(with: URL(string:recipeModel?.recipe.image ?? ""), placeholder: UIImage(named: "default"))
        titleLabel.text = recipeModel?.recipe.label
        ingridientsLabel.text = recipeModel?.recipe.ingredientLines.joined(separator: "\n")
        ingreideintsHeightConstraints.constant = CGFloat(25 * (recipeModel?.recipe.ingredientLines.count ?? 1))
        linkLabel.text = recipeModel?.recipe.url
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func openSafariController() {
        if let urlString = recipeModel?.recipe.url, let _url = URL(string: urlString) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: _url, configuration: config)
            present(vc, animated: true)
        }
        
     
           
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
