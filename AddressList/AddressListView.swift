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
            List {
                Section {
                    ForEach(presenter.addresses) { address in
                        AddressCell(with: address)
                    }
                }
            }
            .navigationTitle("Endereços")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear(perform: presenter.setup)
    }
    
}

struct AddressListView_Previews: PreviewProvider {
    static var previews: some View {
        AddressListView()
    }
}
