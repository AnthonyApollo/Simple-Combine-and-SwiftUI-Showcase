//
//  NetworkingTypes.swift
//  AddressList
//
//  Created by Anthony Apollo on 12/07/22.
//

import Foundation

protocol Router {
    
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
        case .apiError: return "A requisição retornou com código de erro."
        case .decode: return "Não é possível decodificar a resposta do servidor."
        case .unknown: return "Algo inesperado aconteceu."
        case .url: return "A URL informada não é acessível."
        }
    }
    
}

extension Encodable {
    
    internal var dictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] } ?? [:]
    }

}
