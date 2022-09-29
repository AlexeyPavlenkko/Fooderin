//
//  APiRequests.swift
//  Fooderin
//
//  Created by Алексей Павленко on 21.09.2022.
//

import Foundation

//MARK: - FoodCategoriesRequest
struct CategoriesResponse: Decodable {
    let categories: [FoodCategory]
    let populars: [Dish]
    let specials: [Dish]
}

struct FoodCategoriesRequest: APIRequest {
    typealias Response = CategoriesResponse
    
    let path: String
    
    init(path: String = "/dish-categories") {
        self.path = path
    }
}

//MARK: - CategoryDishesRequest
struct CategoryDishesRequest: APIRequest {
    typealias Response = [Dish]
    
    let path: String
    
    init(path: String) {
        self.path = "/dishes/\(path)"
    }
}

//MARK: - FetchOrdersRequest
struct FetchOrdersRequest: APIRequest {
    typealias Response = [Order]
    
    let path: String
    
    init(path: String = "/orders") {
        self.path = path
    }
}

//MARK: - PlaceOrderRequest
struct PlaceOrderRequest: APIRequest {
    typealias Response = Order
    
    let path: String
    let method: Method
    let postData: Data?
    
    init(dishID: String, name: String , method: Method = .post) {
        self.path = "/orders/\(dishID)"
        self.method = method
        self.postData = try? JSONSerialization.data(withJSONObject: ["name" : name])
    }
}
