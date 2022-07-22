//
//  AddressCell.swift
//  AddressList
//
//  Created by Anthony Apollo on 12/07/22.
//

import Combine
import SwiftUI

struct AddressCell: View {
    
    @EnvironmentObject var presenter: AddressListPresenter
    
    private let address: Address
    
    init(with address: Address) {
        self.address = address
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
            presenter.tapCellSubject.send(address)
        }
    }
    
}

struct AddressCell_Previews: PreviewProvider {
    static var previews: some View {
        let address = Address(id: "id", title: "Title", street: "Street", number: "Number", district: "District", city: "City", state: "State", zipCode: "ZIP Code")
        AddressCell(with: address)
    }
}
