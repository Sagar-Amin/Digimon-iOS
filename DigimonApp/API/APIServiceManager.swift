//
//  APIServiceManager.swift
//  DigimonApp
//
//  Created by Sagar Amin on 3/4/25.
//

import Foundation
import Combine

class APIServiceManager {
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
}


protocol APIService {
    func fetchData<T: Decodable>(
            url: String,
            modelType: T.Type
    ) -> AnyPublisher<T, Error>
}


extension APIServiceManager: APIService {
    func fetchData<T: Decodable>(
        url: String,
        modelType: T.Type
    ) -> AnyPublisher<T, Error> where T : Decodable {
        guard let url = URL(string: url) else {
            return Fail(error: APIError.invalidURLError).eraseToAnyPublisher( )
        }
        
        return urlSession.dataTaskPublisher(for: url)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw APIError.noDataError
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    throw APIError.responseCodeError(httpResponse.statusCode)
                }
                return result.data
            }
            .decode(type: modelType.self, decoder: JSONDecoder( ) )
            .eraseToAnyPublisher( )
        
    }
}
