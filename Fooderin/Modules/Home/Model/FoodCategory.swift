//
//  FoodCategory.swift
//  Fooderin
//
//  Created by Алексей Павленко on 20.09.2022.
//

import Foundation

struct FoodCategory: Decodable, CustomStringConvertible {
    let id: String?
    let name: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case image
    }
    
    var description: String {
        return "FoodCategory(id: \(id ?? "-"), name: \(name ?? "-"), image: \(image ?? "-")"
    }
}
