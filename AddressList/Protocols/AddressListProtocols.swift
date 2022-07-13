//
//  AddressListProtocols.swift
//  AddressList
//
//  Created by Anthony Apollo on 13/07/22.
//

import Foundation

protocol AddressListRepositoryOutputProtocol: AnyObject {
    
    func setAddresses(with: [Address])
    
}
