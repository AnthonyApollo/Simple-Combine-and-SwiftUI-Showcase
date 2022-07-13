//
//  APIClient.swift
//  AddressList
//
//  Created by Anthony Apollo on 12/07/22.
//

import Foundation
import Combine

struct APIClient {
    
    private let apiQueue = DispatchQueue(label: "API", qos: .default, attributes: .concurrent)
    private let decoder = JSONDecoder()
    
    func requestJSON<T: Decodable>(for urlRequest: URLRequest) -> AnyPublisher<T, Never> {
        let response = request(urlRequest)
        
         return response
            .decode(type: T.self, decoder: decoder)
            .catch { _ in Empty() } // TODO: Swap for .mapError
            .eraseToAnyPublisher()
    }
    
    func request(_ urlRequest: URLRequest) -> AnyPublisher<Data, URLError> {
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .receive(on: apiQueue)
            .map { $0.0 }
            .eraseToAnyPublisher()
    }
    
}
