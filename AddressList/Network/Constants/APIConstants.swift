//
//  APIConstants.swift
//  AddressList
//
//  Created by Anthony Apollo on 14/07/22.
//

import Foundation

struct APIConstants {
    
    // MARK: - Terms
    static let address = "address"
    static let all = "all"
    static let edit = "edit"
    
    // MARK: - Routes
    static let addressList = "/\(address)/\(all)"
    static let editAddress = "/\(address)/\(edit)"
    static let baseURL = "http://localhost:3000"
    
}
