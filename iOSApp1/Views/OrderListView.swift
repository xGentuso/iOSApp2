import SwiftUI

struct OrderListView: View {
    @ObservedObject var viewModel: CoffeeOrderViewModel
    
    @State private var showingAddOrder = false
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.orders.isEmpty {
                    Text("No orders yet. Tap the '+' to add your first order!")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    ForEach(viewModel.orders) { order in
                        VStack(alignment: .leading) {
                            Text(order.personName)
                                .font(.headline)
                            Text("\(order.size) \(order.coffeeType)")
                                .foregroundColor(.secondary)
                            Text("Sugar: \(order.sugar), Cream: \(order.cream)")
                                .font(.caption)
                        }
                        .padding(.vertical, 5)
                    }
                    .onDelete(perform: viewModel.removeOrder)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Orders")
            .toolbar {
                // Add Button with "+" Icon
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddOrder = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.red)
                    }
                }
            }
            .sheet(isPresented: $showingAddOrder) {
                AddOrderView(viewModel: viewModel)
            }
        }
    }
}

// MARK: - Preview
struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView(viewModel: CoffeeOrderViewModel())
    }
}
