//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Noah Glaser on 7/4/22.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var orderStore: OrderStore
    
    @State private var confirmationMessage = ""
    @State private var showConfirmation = false
    
    @State private var showErrorMessage = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale:  3) {
                    image in
                        image.resizable()
                            .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                Text("Your total is \(orderStore.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                Button("Place Order") {
                    Task {
                       await placeOrder()
                    }
                }.padding()
            }
        }.navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Thank you!", isPresented: $showConfirmation) {
                Button("OK") {
                    
                }
            } message: {
                Text(confirmationMessage)
            }
            .alert("Error!", isPresented: $showErrorMessage) {
                Button("OK") {
                    
                }
            } message: {
                Text("There was an error making your request please try again later.")
            }
        
        
        
    }
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(orderStore.order) else {
            print("Falied to encode order")
            return
        }
        print(String(data: encoded, encoding: .utf8)!, "ENCODED JSON")
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(OrderStore.types[decodedOrder.type].lowercased()) cupcakes is on the way."
            showConfirmation = true
        } catch {
            showErrorMessage = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(orderStore: OrderStore())
    }
}
