//
//  APIClient.swift
//  AddressList
//
//  Created by Anthony Apollo on 12/07/22.
//

import Foundation
import Combine

struct APIClient {
    
    private typealias QueuedPublisher = Publishers.ReceiveOn<URLSession.DataTaskPublisher, DispatchQueue>
    
    private let apiQueue = DispatchQueue(label: "API", qos: .default, attributes: .concurrent)
    private let decoder = JSONDecoder()
    
    private func request(_ urlRequest: URLRequest) -> QueuedPublisher {
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .receive(on: apiQueue)
    }
    
}

extension APIClient {
    
    func requestJSON<T: Decodable>(for urlRequest: URLRequest) -> AnyPublisher<T, Never> {
        let response: QueuedPublisher = request(urlRequest)
        
        return response
            .map { $0.0 }
            .decode(type: T.self, decoder: decoder)
            .catch { _ in Empty() } // TODO: Swap for .mapError
            .eraseToAnyPublisher()
    }
    
}

extension APIClient {
    
    func request(_ urlRequest: URLRequest) -> AnyPublisher<RequestResult, URLError> {
        let response: QueuedPublisher = request(urlRequest)
        
        return response
            .map { mapURLResponse($0.1 as? HTTPURLResponse) }
            .eraseToAnyPublisher()
    }
    
    private func mapURLResponse(_ response: HTTPURLResponse?) -> RequestResult {
        guard let response = response else { return .failure }
        
        switch response.statusCode {
        case (200..<300):
            return .success
        default:
            return .failure
        }
    }
    
}
