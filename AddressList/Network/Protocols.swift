//
//  Protocols.swift
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
    
}
