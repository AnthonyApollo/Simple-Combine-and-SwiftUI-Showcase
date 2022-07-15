//
//  AddressRouter.swift
//  AddressList
//
//  Created by Anthony Apollo on 12/07/22.
//

import Foundation

enum AddressRouter: Router {
    
    case addressList
    
    internal var baseURL: String {
        APIConstants.baseURL
    }
    
    internal var path: String {
        APIConstants.addresses
    }
    
    internal var method: HTTPMethod {
        .get
    }
    
    func asURLRequest() -> URLRequest? {
        guard let url = URL(string: baseURL) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
}
