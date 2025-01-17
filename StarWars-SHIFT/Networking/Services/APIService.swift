//
//  APIService.swift
//  StarWars-SHIFT
//
//  Created by Ivan Semenov on 01.02.2023.
//

import Foundation

final class APIService {
    
    private let apiManager = APIManager()
    
    func getTopic<T: Decodable>(endpoint: EndPointItems, page: Int, completionHandler: @escaping (Result<T, Error>) -> Void) {
        let query = TopicContentQuery(page: page)
        let urlString = endpoint.url
        
        apiManager.loadData(urlString: urlString, query: query) { (result: Result<T, Error>) in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getContentDetails<T: Decodable>(urlString: String, completionHandler: @escaping (Result<T, Error>) -> Void) {
        
        apiManager.loadData(urlString: urlString) { (result: Result<T, Error>) in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

