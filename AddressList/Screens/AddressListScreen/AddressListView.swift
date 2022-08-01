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
                    ForEach(presenter.addresses) {
                        AddressCell(with: $0)
                    }
                }
                .navigationTitle("Endereços")
                .navigationBarTitleDisplayMode(.inline)
            } else {
                EmptyAddressListView()
            }
        }
        .onAppear(perform: presenter.setup)
        .sheet(item: $presenter.addressToEdit) {
            EditAddressSheet(with: $0)
        }
        .alert(item: $presenter.alertMessage) { message in
            Alert(
                title: Text(message.title),
                message: Text(message.description),
                dismissButton: .cancel()
            )
        }
        .environmentObject(presenter)
    }
    
}

struct AddressListView_Previews: PreviewProvider {
    static var previews: some View {
        AddressListView()
    }
}
