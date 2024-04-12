
import Foundation

//MARK: -------- Struct Model Classes - Recipe Module --------

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}


struct Recipe: Decodable {
    let id: Int
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let prepTimeMinutes: Int
    let cookTimeMinutes: Int
    let servings: Int
    let difficulty: String
    let cuisine: String
    let caloriesPerServing: Int
    let tags: [String]
    let userId: Int
    let image: String
    let rating: Double
    let reviewCount: Int
    let mealType: [String]
}

