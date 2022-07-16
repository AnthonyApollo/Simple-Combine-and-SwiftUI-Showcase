//
//  EmptyAddressListView.swift
//  AddressList
//
//  Created by Anthony Apollo on 15/07/22.
//

import SwiftUI
import Combine

struct EmptyAddressListView: View {
    
    var retrySubject: PassthroughSubject<Void, Never>
    
    init(retrySubject: PassthroughSubject<Void, Never>) {
        self.retrySubject = retrySubject
    }
    
    var body: some View {
        VStack(spacing: 50) {
            VStack {
                Text("Você não tem endereços cadastrados.")
                Text("=(")
            }
            Button("Buscar novamente") {
                retrySubject.send()
            }
        }
    }
    
}

//struct EmptyAddressListView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmptyAddressListView()
//    }
//}
