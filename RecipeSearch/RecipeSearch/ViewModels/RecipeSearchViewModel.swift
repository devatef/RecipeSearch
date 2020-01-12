//
//  RecipeViewModel.swift
//  RecipeSearch
//
//  Created by Atef on 1/11/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
import PromiseKit
import RxSwift
import RxCocoa

class RecipeSearchViewModel {
    
       private var _page = 0
       private var oldSearchTerm = ""
       private let _canLoadNextPage = BehaviorRelay<Bool>(value: false)
       private let disposeBag = DisposeBag()
       private let _recipes = BehaviorRelay<[Hit]>(value: [])
       private let _isFetching = BehaviorRelay<Bool>(value: false)
       private let _error = BehaviorRelay<String?>(value: nil)
       
  
    
       var isFetching: Driver<Bool> {
           return _isFetching.asDriver()
       }
       
       var recipes: Driver<[Hit]> {
           return _recipes.asDriver()
       }
       
       var error: Driver<String?> {
           return _error.asDriver()
       }
       
       var hasError: Bool {
           return _error.value != nil
       }
      
       var shouldLoadNextPage: Bool {
              return _canLoadNextPage.value
        }
       
       var numberOfRecipes: Int {
           return _recipes.value.count
       }
       
       func modelForRecipe(at index: Int) -> Hit? {
           guard index < _recipes.value.count else {
               return nil
           }
           return  _recipes.value[index]
       }
       
     func fetchRecipes(searchWord:String) {
        guard !searchWord.isEmpty else {
            return
        }
        if searchWord != oldSearchTerm {
            self._recipes.accept([])
            _page = 0
        }
        oldSearchTerm = searchWord
        self._isFetching.accept(true)
        self._error.accept(nil)
        
        RecipeRepo().searchFor(keyword: searchWord, page: _page*10).done {[weak self] recipeModel in
            print(recipeModel.hits.count)
            self?._isFetching.accept(false)
            self?._recipes.accept((self?._recipes.value)!+recipeModel.hits)
            self?._page += 1
            self?._canLoadNextPage.accept(recipeModel.more)
        }.catch{[weak self] error in
            print(error)
            self?._isFetching.accept(false)
            self?._error.accept(error.localizedDescription)

        }
    
       }
    
    
}
