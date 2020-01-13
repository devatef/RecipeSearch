//
//  SuggessionViewModel.swift
//  RecipeSearch
//
//  Created by Atef on 1/13/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
import RealmSwift

class SuggessionViewModel {
    
    private var _res:Results<SuggessionModel>?
    
    
    init() {
        loadSuggesion()
    }
    
      var numberOfRecipes: Int {
          return _res?.count ?? 0
      }
      
      func modelForSuggest(at index: Int) -> SuggessionModel? {
          guard index < _res?.count ?? 0 else {
              return nil
          }
          return  _res?[index]
      }
    
     func loadSuggesion() {
        do {
              let realm = try Realm()
              _res = realm.objects(SuggessionModel.self).sorted(byKeyPath: "dateCreated" ,ascending: false)
            
        } catch let error {
            print(error)
        }
        
    }
    
    func saveSuggestion(suggest:String) {
     checkNSave(word: suggest)
        
    }
    
    private func checkNSave(word:String){
        do {
            let realm = try Realm()
            
            let cnt = realm.objects(SuggessionModel.self).filter("suggestion == '\(word)'").count
            if(cnt > 1 ){return}  // already saved before
            
            
            if (_res?.count ?? 0) > 9 , let lastSuggest = _res?.last{ // delete last object
                try realm.write {
                    realm.delete(lastSuggest)
                }
            }
            
            try realm.write {  // add new object
                realm.create(SuggessionModel.self, value: ["suggestion": word])
                loadSuggesion() // to add this new model for results
            }
            
        } catch let error as NSError {
            print(error)
        }
        
    }
}
