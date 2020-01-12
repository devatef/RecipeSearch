//
//  ViewController.swift
//  RecipeSearch
//
//  Created by Atef on 1/8/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PKHUD

class RecipeSearchViewController: UIViewController {
   
     @IBOutlet weak var tableView: UITableView!
     @IBOutlet weak var infoLabel: UILabel!

        var recipeSearchViewModel: RecipeSearchViewModel!
        let disposeBag = DisposeBag()

        override func viewDidLoad() {
            super.viewDidLoad()
           setupNavigationBar()
           setupRecipeViewModel()
           setupSearchBarBinding()
           setupTableView()
           setupLoadMore()
        }
    
    private func setupRecipeViewModel(){
           recipeSearchViewModel = RecipeSearchViewModel()
            
            recipeSearchViewModel.recipes.drive(onNext: {[unowned self] (_) in
                self.tableView.reloadData()
                HUD.hide()
            }).disposed(by: disposeBag)
            
            recipeSearchViewModel.error.drive(onNext: {[unowned self] (error) in
                self.infoLabel.isHidden = !self.recipeSearchViewModel.hasError
                HUD.hide()
                self.infoLabel.text = error
                DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                    self.infoLabel.isHidden = true
                }
            }).disposed(by: disposeBag)
    }
    
    private func setupSearchBarBinding(){
          let searchBar = self.navigationItem.searchController!.searchBar
           searchBar.rx.searchButtonClicked
               .asDriver(onErrorJustReturn: ())
               .drive(onNext: { [unowned searchBar] in
                   searchBar.resignFirstResponder()
                HUD.show(.progress)
                self.recipeSearchViewModel.fetchRecipes(searchWord: searchBar.text ?? "")
                }).disposed(by: disposeBag)
           
           searchBar.rx.cancelButtonClicked
               .asDriver(onErrorJustReturn: ())
               .drive(onNext: { [unowned searchBar] in
                   searchBar.resignFirstResponder()
               }).disposed(by: disposeBag)

    }
        
      private func setupLoadMore(){
          let loadNextPage = self.tableView.rx.contentOffset.asDriver()
              .flatMap {[unowned self]  offset in
                 return self.tableView.isNearBottomEdge(edgeOffset: 20.0)  && self.recipeSearchViewModel.shouldLoadNextPage
                  ? Signal.just((true))
                  : Signal.just((false))
          }
         
          loadNextPage.asObservable().throttle(.seconds(2), scheduler: MainScheduler.instance).subscribe (onNext: {[unowned self] val in
              if(val){
                  let searchBar = self.navigationItem.searchController!.searchBar
                  HUD.show(.progress)
                  self.recipeSearchViewModel.fetchRecipes(searchWord: searchBar.text ?? "")
              }
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
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let details = self.storyboard?.instantiateViewController(withIdentifier: String(describing: RecipeDeatilsViewController.self)) as! RecipeDeatilsViewController
            
            if let model = recipeSearchViewModel.modelForRecipe(at: indexPath.row) {
                        details.recipeModel = model
            }
            self.navigationController?.pushViewController(details, animated: true)
        }
            
    }



