//
//  AddressListPresenter.swift
//  AddressList
//
//  Created by Anthony Apollo on 12/07/22.
//

import Foundation
import Combine

class AddressListPresenter: ObservableObject {
    
    @Published var addresses: [Address] = []
    
    private lazy var repository = AddressListRepository(output: self)
    
    func setup() {
        repository.getAddresses()
    }
    
}

extension AddressListPresenter: AddressListRepositoryOutputProtocol {
    
    internal func setAddresses(with list: [Address]) {
        self.addresses = list
    }
    
}
