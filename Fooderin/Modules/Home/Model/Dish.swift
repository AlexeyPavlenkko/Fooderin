//
//  PopularDish.swift
//  Fooderin
//
//  Created by Алексей Павленко on 20.09.2022.
//

import Foundation

struct Dish: Decodable {
    let id: String?
    let name: String?
    let description: String?
    let image: String?
    let calories: Int?
    
    var formattedCalories: String {
        return "\(calories ?? 0) calories"
    }
}
