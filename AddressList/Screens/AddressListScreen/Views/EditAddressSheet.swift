//
//  EditAddressSheet.swift
//  AddressList
//
//  Created by Anthony Apollo on 15/07/22.
//

import Combine
import SwiftUI

struct EditAddressSheet: View {
    
    var address: Address
    
    @EnvironmentObject var presenter: AddressListPresenter
    
    let editAddressSubject: PassthroughSubject<Void, Never>?
    
    init(with address: Address, editAddressSubject: PassthroughSubject<Void, Never>? = nil) {
        self.address = address
        self.editAddressSubject = editAddressSubject
    }
    
    var body: some View {
        VStack(spacing: 50) {
            Text("ID: \(address.id)")
            Text("Se esse APP fosse real, você poderia editar o endereço aqui.")
            Button("E salvar com esse botão.") {
                editAddressSubject?.send()
            }
            Text(";)")
        }
        .alert(item: $presenter.editAddressMessage) { message in
            Alert(
                title: Text(message.title),
                message: Text(message.description),
                dismissButton: .cancel()
            )
        }
    }
    
}

struct EditAddressSheet_Previews: PreviewProvider {
    static var previews: some View {
        let address = Address(id: "id", title: "Title", street: "Street", number: "Number", district: "District", city: "City", state: "State", zipCode: "ZIP Code")
        EditAddressSheet(with: address)
    }
}
