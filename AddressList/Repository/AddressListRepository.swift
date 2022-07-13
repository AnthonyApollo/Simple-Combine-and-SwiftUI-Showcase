//
//  AddressListRepository.swift
//  AddressList
//
//  Created by Anthony Apollo on 13/07/22.
//

import Foundation
import Combine

class AddressListRepository {
    
    private var subscriptions = Set<AnyCancellable>()
    private let apiClient = APIClient()
    
    private unowned let output: AddressListRepositoryOutputProtocol
    
    init(output: AddressListRepositoryOutputProtocol) {
        self.output = output
    }
    
    internal func getAddresses() {
        guard let router = AddressRouter.addressList.asURLRequest() else { return }
        let request: AnyPublisher<[Address], Never> = apiClient.requestJSON(for: router)
        
        request
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { addresses in
                self.output.setAddresses(with: addresses)
            })
            .store(in: &subscriptions)
    }
    
}
