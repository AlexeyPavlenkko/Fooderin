//
//  NetworkService.swift
//  Fooderin
//
//  Created by Алексей Павленко on 21.09.2022.
//

import Foundation

//MARK: - NetworkingErrors
enum NetworkingErrors: LocalizedError {
    case urlNotValid
    case responseNotValid
    case notContainingData
    case errorDecoding
    
    var errorDescription: String? {
        switch self {
        case .urlNotValid:
            return "Provided url is not valid."
        case .responseNotValid:
            return "Response from server is not valid."
        case .notContainingData:
            return "Response from server does not contain data."
        case .errorDecoding:
            return "Response from server could not be decoded."
        }
    }
}

//MARK: - NetworkService
class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    public func send<Request: APIRequest>(request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) {
        guard let urlRequest = request.urlRequest else {
            completion(.failure(NetworkingErrors.urlNotValid))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkingErrors.notContainingData))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NetworkingErrors.responseNotValid))
                return
            }
            do {
                let decodedObject = try request.decode(from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(NetworkingErrors.errorDecoding))
            }
        }
        dataTask.resume()
    }
}
