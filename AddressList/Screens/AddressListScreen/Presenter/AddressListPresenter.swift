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
    
    @Published var addresses: [Address] = []
    @Published var shouldDisplayListView: Bool = true
    @Published var addressToEdit: Address? = nil
    
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
    
}

extension AddressListPresenter: AddressListRepositoryOutputProtocol {
    
    internal func setAddresses(with list: [Address]) {
        if list.isEmpty {
            shouldDisplayListView = false
        } else {
            self.shouldDisplayListView = true
            self.addresses = list
        }
    }
    
}
