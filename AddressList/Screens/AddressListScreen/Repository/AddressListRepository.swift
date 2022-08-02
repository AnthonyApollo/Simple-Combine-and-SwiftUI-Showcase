//
//  AddressListRepository.swift
//  AddressList
//
//  Created by Anthony Apollo on 13/07/22.
//

import Foundation
import Combine

class AddressListRepository {
    
    private typealias Completion<T: Error> = Subscribers.Completion<T>
    
    private var subscriptions = Set<AnyCancellable>()
    private let apiClient = APIClient()
    
    private unowned let output: AddressListRepositoryOutputProtocol
    
    init(output: AddressListRepositoryOutputProtocol) {
        self.output = output
    }
    
    func getAddresses() {
        let router: AddressRouter = .addressList
        guard let urlRequest = router.asURLRequest() else { return }
        let response: AnyPublisher<[Address], RequestError> = apiClient.requestJSON(for: urlRequest)
        
        response
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { self.receive(completion: $0) },
                receiveValue: { self.output.getAddressesSuccess(with: $0) }
            )
            .store(in: &subscriptions)
    }
    
    func editAddress(_ address: Address) {
        let router: AddressRouter = .edit(address)
        guard let urlRequest = router.asURLRequest() else { return }
        let response = apiClient.request(urlRequest)
        
        response
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { self.receive(completion: $0) },
                receiveValue: { self.output.editAddressResult($0) }
            )
            .store(in: &subscriptions)
    }
    
    private func receive(completion: Completion<RequestError>) {
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
