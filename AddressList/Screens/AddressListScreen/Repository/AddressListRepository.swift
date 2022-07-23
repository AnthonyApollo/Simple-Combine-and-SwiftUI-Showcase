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
    
    func getAddresses() {
        guard let router = AddressRouter.addressList.asURLRequest() else { return }
        let request: AnyPublisher<[Address], RequestError> = apiClient.requestJSON(for: router)
        
        request
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { self.receive(completion: $0) },
                receiveValue: { self.output.getAddressesSuccess(with: $0) }
            )
            .store(in: &subscriptions)
    }
    
    func editAddress(_ address: Address) {
        guard let router = AddressRouter.edit(address).asURLRequest() else { return }
        let request = apiClient.request(router)
        
        request
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { self.receive(completion: $0) },
                receiveValue: { self.output.editAddressResult($0) }
            )
            .store(in: &subscriptions)
    }
    
    private func receive(completion: Subscribers.Completion<RequestError>) {
        if case .failure(let error) = completion {
            self.output.display(error: error)
        }
    }
    
}

protocol AddressListRepositoryOutputProtocol: AnyObject {
    
    func getAddressesSuccess(with: [Address])
    func editAddressResult(_: RequestResult)
    func display(error: RequestError)
    
}
