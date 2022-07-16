//
//  AddressCell.swift
//  AddressList
//
//  Created by Anthony Apollo on 12/07/22.
//

import Combine
import SwiftUI

struct AddressCell: View {
    
    private let address: Address
    var onTapSubject: PassthroughSubject<Address, Never>?
    
    init(with address: Address, onTapSubject: PassthroughSubject<Address, Never>? = nil) {
        self.address = address
        self.onTapSubject = onTapSubject
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(address.title).bold()
            Text("\(address.street), \(address.number) - \(address.district)")
            Text(address.zipCode)
            Text("\(address.city) - \(address.state)")
        }
        .padding()
        .onTapGesture {
            onTapSubject?.send(address)
        }
    }
    
}

struct AddressCell_Previews: PreviewProvider {
    static var previews: some View {
        let address = Address(id: "id", title: "Title", street: "Street", number: "Number", district: "District", city: "City", state: "State", zipCode: "ZIP Code")
        AddressCell(with: address)
    }
}
