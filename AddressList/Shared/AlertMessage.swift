//
//  AlertMessage.swift
//  AddressList
//
//  Created by Anthony Apollo on 22/07/22.
//

import Foundation

enum AlertMessage: Identifiable {
    
    case success(String)
    case failure(String)
    
    var id: Int {
        switch self {
        case .success:
            return 1
        case .failure:
            return 0
        }
    }
    
    var title: String {
        switch self {
        case .success:
            return "( ͡° ͜ʖ ͡°)"
        case .failure:
            return "t(>.<t)"
        }
    }
    
    var description: String {
        switch self {
        case .success(let message):
            return message
        case .failure(let message):
            return message
        }
    }
    
}
