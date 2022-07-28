//
//  EditAddressSheet.swift
//  AddressList
//
//  Created by Anthony Apollo on 15/07/22.
//

import Combine
import SwiftUI

struct EditAddressSheet: View {
    
    @EnvironmentObject var presenter: AddressListPresenter
    @Environment(\.presentationMode) var presentationMode
    
    var address: Address
    
    init(with address: Address) {
        self.address = address
    }
    
    var body: some View {
        VStack(spacing: 50) {
            Text("ID: \(address.id)")
            Text("Se esse APP fosse real, você poderia editar o endereço aqui.")
            Button("E salvar com esse botão.") {
                presenter.actionSubject.send(.editAddress)
            }
            Text(";)")
        }
        .alert(item: $presenter.alertMessage) { message in
            Alert(
                title: Text(message.title),
                message: Text(message.description),
                dismissButton: .default(
                    Text("OK"),
                    action: { onDismiss(message: message) }
                )
            )
        }
    }
    
    private func onDismiss(message: AlertMessage) {
        presenter.actionSubject.send(.dismissedAddressEditAlert(message))
    }
    
}

struct EditAddressSheet_Previews: PreviewProvider {
    static var previews: some View {
        let address = Address(id: "id", title: "Title", street: "Street", number: "Number", district: "District", city: "City", state: "State", zipCode: "ZIP Code")
        EditAddressSheet(with: address)
    }
}
