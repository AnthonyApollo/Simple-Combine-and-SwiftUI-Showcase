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
    @Published var alertMessage: AlertMessage? = nil
    
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
        case .dismissedAddressEditAlert(let message):
            dismissEditAddressSheetIfNeeded(for: message)
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
    
    private func dismissEditAddressSheetIfNeeded(for message: AlertMessage) {
        guard case .success = message else { return }
        
        alertMessage = nil
        addressToEdit = nil
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
            self.alertMessage = .success("Endereço salvo com sucesso!")
        case .failure(let requestError):
            display(error: requestError)
        }
    }
    
    func display(error: RequestError) {
        self.alertMessage = .failure(error.localizedDescription)
        
        if addresses.isEmpty {
            shouldDisplayListView = false
        }
    }
    
}

extension AddressListPresenter {
    
    enum Action {
        
        case editAddress
        case dismissedAddressEditAlert(AlertMessage)
        case getListRetry
        case tapAddressCell(Address)
        
    }
    
}
