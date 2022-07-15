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
        let request: AnyPublisher<[Address], RequestError> = apiClient.requestJSON(for: router)
        
        request
            .receive(on: DispatchQueue.main)
            // TODO: Add error handling flow
            .sink(receiveCompletion: { print($0) }, receiveValue: { self.output.setAddresses(with: $0) })
            .store(in: &subscriptions)
    }
    
}

protocol AddressListRepositoryOutputProtocol: AnyObject {
    
    func setAddresses(with: [Address])
    
}
