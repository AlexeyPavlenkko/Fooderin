//
//  APiRequests.swift
//  Fooderin
//
//  Created by Алексей Павленко on 21.09.2022.
//

import Foundation

//MARK: - APIResponse
fileprivate struct APIResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String?
    let data: T
}

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
    
    func decode(from data: Data) throws -> CategoriesResponse {
        let decodedApiResponse = try JSONDecoder().decode(APIResponse<CategoriesResponse>.self, from: data)
        return decodedApiResponse.data
    }
}

//MARK: - CategoryDishesRequest
struct CategoryDishesRequest: APIRequest {
    typealias Response = [Dish]
    
    let path: String
    
    init(path: String) {
        self.path = "/dishes/\(path)"
    }
    
    func decode(from data: Data) throws -> [Dish] {
        let decodedApiResponse = try JSONDecoder().decode(APIResponse<[Dish]>.self, from: data)
        return decodedApiResponse.data
    }
}

//MARK: - FetchOrdersRequest
struct FetchOrdersRequest: APIRequest {
    typealias Response = [Order]
    
    let path: String
    
    init(path: String = "/orders") {
        self.path = path
    }
    
    func decode(from data: Data) throws -> [Order] {
        let decodedResponse = try JSONDecoder().decode(APIResponse<[Order]>.self, from: data)
        return decodedResponse.data
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
    
    func decode(from data: Data) throws -> Order {
        let decodedResponse = try JSONDecoder().decode(APIResponse<Order>.self, from: data)
        return decodedResponse.data
    }
}
