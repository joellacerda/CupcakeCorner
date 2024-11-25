//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Joel Lacerda on 22/11/24.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("ZIP", text: $order.zip)
            }
            
            Section {
                NavigationLink("Checkout") {
                    CheckoutView(order: order)
                }
            }
            .disabled(!order.hasValidAddress)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AddressView(order: Order())
    }
}
