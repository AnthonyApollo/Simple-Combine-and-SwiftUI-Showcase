//
//  AddressListPresenter.swift
//  AddressList
//
//  Created by Anthony Apollo on 12/07/22.
//

import Foundation
import Combine

class AddressListPresenter: ObservableObject {
    
    private var subscriptions = Set<AnyCancellable>()
    let actionSubject = PassthroughSubject<Action, Never>()
    
    @Published var addresses: [Address] = []
    @Published var shouldDisplayListView: Bool = true
    @Published var addressToEdit: Address? = nil
    @Published var editAddressMessage: AlertMessage? = nil
    
    private lazy var repository = AddressListRepository(output: self)
    
    func setup() {
        getAddresses()
        subscribeActions()
    }
    
    private func getAddresses() {
        repository.getAddresses()
    }
    
    private func subscribeActions() {
        actionSubject
            .sink { self.receive(action: $0) }
            .store(in: &subscriptions)
    }
    
    private func receive(action: Action) {
        switch action {
        case .editAddress:
            self.editAddress()
        case .getListRetry:
            self.getAddresses()
        case .tapAddressCell(let address):
            self.addressToEdit = address
        }
    }
    
    private func editAddress() {
        guard let addressToEdit = addressToEdit else { return }
        
        repository.editAddress(addressToEdit)
    }
    
}

extension AddressListPresenter: AddressListRepositoryOutputProtocol {
    
    func getAddressesSuccess(with list: [Address]) {
        if list.isEmpty {
            shouldDisplayListView = false
        } else {
            self.shouldDisplayListView = true
            self.addresses = list
        }
    }
    
    func editAddressResult(_ result: RequestResult) {
        switch result {
        case .success:
            self.editAddressMessage = .success("Endereço salvo com sucesso!")
        case .failure(let requestError):
            editAddressError(requestError)
        }
    }
    
    func editAddressError(_ error: RequestError) {
        self.editAddressMessage = .failure(error.localizedDescription)
    }
    
}

extension AddressListPresenter {
    
    enum Action {
        
        case editAddress
        case getListRetry
        case tapAddressCell(Address)
        
    }
    
}
