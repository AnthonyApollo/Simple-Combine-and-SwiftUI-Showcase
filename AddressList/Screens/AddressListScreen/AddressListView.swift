//
//  AddressListView.swift
//  AddressList
//
//  Created by Anthony Apollo on 12/07/22.
//

import Combine
import SwiftUI

struct AddressListView: View {
    
    @ObservedObject var presenter: AddressListPresenter = .init()
    
    var body: some View {
        NavigationView {
            if presenter.shouldDisplayListView {
                List {
                    Section {
                        ForEach(presenter.addresses) {
                            AddressCell(with: $0, onTapSubject: presenter.tapCellSubject)
                        }
                    }
                }
                .navigationTitle("Endereços")
                .navigationBarTitleDisplayMode(.inline)
            } else {
                EmptyAddressListView(retrySubject: presenter.retrySubject)
            }
        }
        .onAppear(perform: presenter.setup)
        .sheet(item: $presenter.addressToEdit) {
            EditAddressSheet(with: $0, editAddressSubject: presenter.editAddressSubject)
        }
        .environmentObject(presenter)
    }
    
}

struct AddressListView_Previews: PreviewProvider {
    static var previews: some View {
        AddressListView()
    }
}
