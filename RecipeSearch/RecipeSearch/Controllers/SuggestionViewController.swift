//
//  SuggestionViewController.swift
//  RecipeSearch
//
//  Created by Atef on 1/13/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    
    var suggestionViewModel:SuggessionViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        suggestionViewModel = SuggessionViewModel()
        tableView?.register(SuggestionCell.nib, forCellReuseIdentifier: SuggestionCell.identifier)

    }

    func loadSuggession()  {
        suggestionViewModel.loadSuggesion()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestionViewModel.numberOfRecipes
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: SuggestionCell.identifier, for: indexPath) as! SuggestionCell
        
        if let model = suggestionViewModel.modelForSuggest(at: indexPath.row) {
                       cell.configureWith(item: model)
            }
    
        return cell
    
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
