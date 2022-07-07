//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Noah Glaser on 7/4/22.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderStore: OrderStore
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderStore.order.name)
                TextField("Street address", text: $orderStore.order.streetAddress)
                TextField("City", text: $orderStore.order.city)
                TextField("Zip", text: $orderStore.order.zip)
            }
            Section {
                NavigationLink {
                    CheckoutView(orderStore: orderStore)
                } label: {
                    Text("Check out")
                }
            }.disabled(!orderStore.order.hasValidAddress)
        }.navigationTitle("Delivery detials")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(orderStore: OrderStore())
        }
    }
}
