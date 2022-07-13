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
    private let apiClient = APIClient()
    
    @Published var addresses: [Address] = []
    
    func setup() {
        do {
            guard let router = AddressRouter.addressList.asURLRequest() else { return }
            let request: AnyPublisher<[Address], Never> = apiClient.requestJSON(for: router)
            
            request
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { addresses in
                    self.addresses = addresses
                })
                .store(in: &subscriptions)
        } catch {
            print("error") // TODO: Handle errors
        }
        
    }
    
}
