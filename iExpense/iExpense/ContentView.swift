//
//  ContentView.swift
//  iExpense
//
//  Created by Noah Glaser on 5/29/22.
//

import SwiftUI


struct ExpenseItemView: View {
    
    let item: ExpenseItem
    
    var textColor: Color {
        if item.amount < 10 {
            return .green
        } else if item.amount < 100 {
            return .purple
        } else {
            return .red
        }
    }
    
    var fontMoney: Font {
        if item.amount < 10 {
            return .body
        } else if item.amount < 100 {
            return .title
        } else {
            return .largeTitle
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(textColor)
                Text(item.type)
                    .foregroundColor(textColor)
            }
            Spacer()
            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                .font(fontMoney)
                .foregroundColor(textColor)
        }
    }
}

struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
        
    var body: some View {
        NavigationView {
            List {
                Section("Business") {
                    ForEach(expenses.items.filter{ $0.type == "Business"}) { item in
                        ExpenseItemView(item: item)
                    }.onDelete(perform: removeItems(type: "Business"))
                }
                Section("Personal") {
                    ForEach(expenses.items.filter{ $0.type == "Personal"}) { item in
                        ExpenseItemView(item: item)
                    }.onDelete(perform: removeItems(type: "Personal"))

                }
                
            }.navigationTitle("IExpense")
                .toolbar {
                    Button {
                        showingAddExpense = true

                    } label: {
                        Image(systemName: "plus")
                    }
                }
        }.sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItems(type: String) -> (IndexSet) -> Void {
        return { offsets in
           var itemTypeFiltered = expenses.items.filter { $0.type == type }
            itemTypeFiltered.remove(atOffsets: offsets)
            let nonEditItems = expenses.items.filter { $0.type != type }
            expenses.items = expenses.items.filter { item in
                itemTypeFiltered.contains(where: {$0.id == item.id}) || nonEditItems.contains(where: {$0.id == item.id})
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
