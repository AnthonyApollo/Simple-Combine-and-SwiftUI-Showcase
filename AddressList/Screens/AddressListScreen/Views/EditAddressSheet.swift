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
    
    var body: some View {
        VStack(spacing: 50) {
            Text("ID: \(address.id)")
            VStack {
                Text("Se esse APP fosse real, você poderia editar o endereço aqui.")
                Text(";)")
            }
            Button("E salvar com esse botão.") {
                print("teste")
            }
        }
    }
    
}

struct EditAddressSheet_Previews: PreviewProvider {
    static var previews: some View {
        let address = Address(id: "id", title: "Title", street: "Street", number: "Number", district: "District", city: "City", state: "State", zipCode: "ZIP Code")
        EditAddressSheet(address: address)
    }
}
