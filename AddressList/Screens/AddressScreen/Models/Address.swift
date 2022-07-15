//
//  Address.swift
//  AddressList
//
//  Created by Anthony Apollo on 12/07/22.
//

import Foundation

struct Address: Codable, Identifiable {
    
    let id: String
    let title: String
    let street: String
    let number: String
    let district: String
    let city: String
    let state: String
    let zipCode: String
    
}
