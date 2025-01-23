//
//  AddOrderView.swift
//  TimHortonsApp
//
//  Created by ryan mota on 2025-01-23.
//

import SwiftUI

struct AddOrderView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: CoffeeOrderViewModel
    
    @State private var personName: String = ""
    @State private var coffeeType: String = ""
    @State private var size: String = ""
    @State private var sugar: String = "0"
    @State private var cream: String = "0"
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Person")) {
                    TextField("Name", text: $personName)
                }
                Section(header: Text("Coffee Details")) {
                    TextField("Coffee Type", text: $coffeeType)
                    TextField("Size (Small, Medium, Large)", text: $size)
                    TextField("Sugar", text: $sugar)
                        .keyboardType(.numberPad)
                    TextField("Cream", text: $cream)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Add an Order")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newOrder = CoffeeOrder(
                            personName: personName,
                            coffeeType: coffeeType,
                            size: size,
                            sugar: Int(sugar) ?? 0,
                            cream: Int(cream) ?? 0
                        )
                        viewModel.addOrder(newOrder)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddOrderView_Previews: PreviewProvider {
    static var previews: some View {
        AddOrderView(viewModel: CoffeeOrderViewModel())
    }
}
