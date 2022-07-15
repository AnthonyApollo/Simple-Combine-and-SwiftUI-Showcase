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
    
    func requestJSON<T: Decodable>(for urlRequest: URLRequest) -> AnyPublisher<T, RequestError> {
        let response: QueuedPublisher = request(urlRequest)
        
        return response
            .map { $0.0 }
            .decode(type: T.self, decoder: decoder)
            .mapError(mapRequestError)
            .eraseToAnyPublisher()
    }
    
    private func mapRequestError(_ error: Error) -> RequestError {
        switch error {
        case is URLError:
            return .url
        case is DecodingError:
            return .decode
        default:
            return .unknown
        }
    }
    
}

extension APIClient {
    
    func request(_ urlRequest: URLRequest) -> AnyPublisher<RequestResult, RequestError> {
        let response: QueuedPublisher = request(urlRequest)
        
        return response
            .map { mapURLResponse($0.1) }
            .mapError { _ in .url }
            .eraseToAnyPublisher()
    }
    
    private func mapURLResponse(_ response: URLResponse) -> RequestResult {
        guard let urlResponse = response as? HTTPURLResponse else {
            return .failure(.unknown)
        }
        
        switch urlResponse.statusCode {
        case (200..<300):
            return .success
        default:
            return .failure(.apiError)
        }
    }
    
}
