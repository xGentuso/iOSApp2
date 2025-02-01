//
//  AddOrderView.swift
//  TimHortonsApp
//
//  Created by Ryan Mota on 2025-01-23.
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
    
    // Alert State
    @State private var showAlert = false
    @State private var alertMessage = ""

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
                        handleSave()
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    // MARK: - Handle Order Saving
    private func handleSave() {
        // Validate input before creating an order
        guard !personName.trimmingCharacters(in: .whitespaces).isEmpty,
              !coffeeType.trimmingCharacters(in: .whitespaces).isEmpty,
              !size.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Please fill out all fields."
            showAlert = true
            return
        }
        
        // Create a new CoffeeOrder instance
        let newOrder = CoffeeOrder(
            personName: personName,
            coffeeType: coffeeType,
            size: size,
            sugar: Int(sugar) ?? 0,
            cream: Int(cream) ?? 0
        )
        
        // Add the new order to the view model
        viewModel.addOrder(newOrder)
        
        // Dismiss the AddOrderView
        dismiss()
    }
}

// MARK: - Preview
struct AddOrderView_Previews: PreviewProvider {
    static var previews: some View {
        AddOrderView(viewModel: CoffeeOrderViewModel())
    }
}
