//
//  NetworkingTypes.swift
//  AddressList
//
//  Created by Anthony Apollo on 12/07/22.
//

import Foundation

protocol Router: CaseIterable {
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    
    func asURLRequest() -> URLRequest?
    
}

enum HTTPMethod: String {
    
    case get = "GET"
    case put = "PUT"
    
}

enum RequestResult {
    
    case success
    case failure(RequestError)
    
}

enum RequestError: LocalizedError, Identifiable {
    
    var id: String { localizedDescription }
  
    case apiError
    case decode
    case unknown
    case url
  
    var errorDescription: String? {
        switch self {
        case .apiError: return "The request returned with error status code."
        case .decode: return "The server responded with garbage."
        case .unknown: return "Something unexpected happened."
        case .url: return "Given URL is unreachable."
        }
    }
    
}

extension Encodable {
    
    internal var dictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] } ?? [:]
    }

}
