//
//  AddressRouter.swift
//  AddressList
//
//  Created by Anthony Apollo on 12/07/22.
//

import Foundation

enum AddressRouter: Router {
    
    case addressList
    case edit(Address?)
    
    internal var baseURL: String {
        APIConstants.baseURL
    }
    
    internal var path: String {
        switch self {
        case .addressList:
            return APIConstants.addressList
        case .edit:
            return APIConstants.editAddress
        }
    }
    
    internal var method: HTTPMethod {
        switch self {
        case .addressList:
            return .get
        case .edit:
            return .put
        }
    }
    
    internal func asURLRequest() -> URLRequest? {
        guard let url = URL(string: baseURL) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .edit(let address):
            let dictionary = address.dictionary
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        default:
            break
        }
        
        return urlRequest
    }
    
}
