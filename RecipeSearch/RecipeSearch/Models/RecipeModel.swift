//
//  RecipeModel.swift
//  RecipeSearch
//
//  Created by Atef on 1/10/20.
//  Copyright © 2020 Atef. All rights reserved.
//
//   let recipeModel = try? newJSONDecoder().decode(RecipeModel.self, from: jsonData)

import Foundation

// MARK: - RecipeModel
struct RecipeModel: Codable {
    let q: String
    let from, to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
    let bookmarked, bought: Bool
}

// MARK: - Recipe
struct Recipe: Codable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let shareAs: String
    let yield: Int
    let dietLabels: [String]
    let healthLabels: [String]
    let cautions: [String]
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories, totalWeight: Double
    let totalTime: Int
    let totalNutrients, totalDaily: [String: Total]
    let digest: [Digest]
}

// MARK: - Digest
struct Digest: Codable {
    let label, tag: String
    let schemaOrgTag: SchemaOrgTag?
    let total: Double
    let hasRDI: Bool
    let daily: Double
    let unit: Unit
    let sub: [Digest]?
}

enum SchemaOrgTag: String, Codable {
    case carbohydrateContent = "carbohydrateContent"
    case cholesterolContent = "cholesterolContent"
    case fatContent = "fatContent"
    case fiberContent = "fiberContent"
    case proteinContent = "proteinContent"
    case saturatedFatContent = "saturatedFatContent"
    case sodiumContent = "sodiumContent"
    case sugarContent = "sugarContent"
    case transFatContent = "transFatContent"
}

enum Unit: String, Codable {
    case empty = "%"
    case g = "g"
    case iu = "IU"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}
/*
enum HealthLabel: String, Codable {
    case alcoholFree = "Alcohol-Free"
    case peanutFree = "Peanut-Free"
    case sugarConscious = "Sugar-Conscious"
    case treeNutFree = "Tree-Nut-Free"
}*/

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String
    let weight: Double
}

// MARK: - Total
struct Total: Codable {
    let label: String
    let quantity: Double
    let unit: Unit
}

// MARK: - Error
struct LimitsError: Codable {
    let status: String
    let message: String
}
