//
//  APIRequest.swift
//  Fooderin
//
//  Created by Алексей Павленко on 21.09.2022.
//

import Foundation

protocol APIRequest {
    associatedtype Response: Decodable
    
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var urlRequest: URLRequest? { get }
    var postData: Data? { get }
    var host: String { get }
    var method: Method { get }
    
    func decode(from data: Data) throws -> Response
}

extension APIRequest {
    var host: String { "pavlenkkko-fooderin.glitch.me" }
    var postData: Data? { nil }
    var method: Method { .get }
    var queryItems: [URLQueryItem]? { nil }
    
    var urlRequest: URLRequest? {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else { return nil }
        var request1 = URLRequest(url: url)
        
        if let data = postData {
            request1.httpBody = data
            request1.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request1.httpMethod = method.rawValue
        }
        
        return request1
    }
}
