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
    
    let retrySubject = PassthroughSubject<Void, Never>()
    let tapCellSubject = PassthroughSubject<Address, Never>()
    let editAddressSubject = PassthroughSubject<Void, Never>()
    
    @Published var addresses: [Address] = []
    @Published var shouldDisplayListView: Bool = true
    @Published var addressToEdit: Address? = nil
    @Published var editAddressMessage: AlertMessage? = nil
    
    private lazy var repository = AddressListRepository(output: self)
    
    func setup() {
        getAddresses()
        subscribe()
    }
    
    private func getAddresses() {
        repository.getAddresses()
    }
    
    private func subscribe() {
        subscribeRetryButton()
        subscribeCellTap()
        subscribeEditAddress()
    }
    
    private func subscribeRetryButton() {
        retrySubject
            .sink { self.getAddresses() }
            .store(in: &subscriptions)
    }
    
    private func subscribeCellTap() {
        tapCellSubject
            .sink { self.addressToEdit = $0 }
            .store(in: &subscriptions)
    }
    
    private func subscribeEditAddress() {
        editAddressSubject
            .sink { self.editAddress() }
            .store(in: &subscriptions)
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
