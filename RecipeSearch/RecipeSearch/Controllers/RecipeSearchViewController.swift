//
//  ViewController.swift
//  RecipeSearch
//
//  Created by Atef on 1/8/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import UIKit
import RxSwift

class RecipeSearchViewController: UIViewController {
   
     @IBOutlet weak var tableView: UITableView!
     @IBOutlet weak var infoLabel: UILabel!
     @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

        var recipeSearchViewModel: RecipeSearchViewModel!
        let disposeBag = DisposeBag()

        override func viewDidLoad() {
            super.viewDidLoad()
            
           setupNavigationBar()
           setupRecipeViewModel()
           setupSearchBarBinding()
           setupTableView()
        }
    
    private func setupRecipeViewModel(){
        recipeSearchViewModel = RecipeSearchViewModel()
            
            recipeSearchViewModel.recipes.drive(onNext: {[unowned self] (_) in
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
            
            recipeSearchViewModel.isFetching.drive(activityIndicatorView.rx.isAnimating)
                .disposed(by: disposeBag)
        
            recipeSearchViewModel.error.drive(onNext: {[unowned self] (error) in
                self.infoLabel.isHidden = !self.recipeSearchViewModel.hasError
                self.infoLabel.text = error
            }).disposed(by: disposeBag)
    }
    
    private func setupSearchBarBinding(){
        let searchBar = self.navigationItem.searchController!.searchBar
                   searchBar.rx.searchButtonClicked
                       .asDriver(onErrorJustReturn: ())
                       .drive(onNext: { [unowned searchBar] in
                           searchBar.resignFirstResponder()
                       }).disposed(by: disposeBag)
                   
                   searchBar.rx.cancelButtonClicked
                       .asDriver(onErrorJustReturn: ())
                       .drive(onNext: { [unowned searchBar] in
                           searchBar.resignFirstResponder()
                       }).disposed(by: disposeBag)

    }
        
        private func setupNavigationBar() {
            navigationItem.searchController = UISearchController(searchResultsController: nil)
            self.definesPresentationContext = true
            navigationItem.searchController?.dimsBackgroundDuringPresentation = false
            navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
            
            navigationItem.searchController?.searchBar.sizeToFit()
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        private func setupTableView() {
            tableView?.estimatedRowHeight = 100
            tableView?.rowHeight = UITableView.automaticDimension
            tableView?.register(RecipeCell.nib, forCellReuseIdentifier: RecipeCell.identifier)
        }
        
    }

    extension RecipeSearchViewController: UITableViewDataSource, UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return recipeSearchViewModel.numberOfRecipes
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.identifier, for: indexPath) as! RecipeCell
            if let model = recipeSearchViewModel.modelForRecipe(at: indexPath.row) {
                cell.configureWith(item: model)
            }
            return cell
        }
            
    }



