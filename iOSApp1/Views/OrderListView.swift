//
//  OrderListView.swift
//  TimHortonsApp
//
//  Created by ryan mota on 2025-01-23.
//

import SwiftUI

struct OrderListView: View {
    @ObservedObject var viewModel: CoffeeOrderViewModel
    @State private var showingAddOrder = false
    
    var body: some View {
        List {
            ForEach(viewModel.orders) { order in
                OrderRowView(order: order)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
            .onDelete(perform: viewModel.removeOrder)
        }
        // Apply a list style that suits your design
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color(.systemGroupedBackground)) // behind the list
        
        .navigationTitle("Tim Hortons Orders")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddOrder = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        // Show the AddOrderView as a sheet
        .sheet(isPresented: $showingAddOrder) {
            AddOrderView(viewModel: viewModel)
        }
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OrderListView(viewModel: CoffeeOrderViewModel())
        }
    }
}
