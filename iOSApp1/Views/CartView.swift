// CartView.swift
import SwiftUI

struct CartView: View {
    @ObservedObject var cartViewModel: CartViewModel
    
    var body: some View {
        VStack {
            if cartViewModel.items.isEmpty {
                // If the cart is empty, show a friendly message
                Text("Your cart is empty!")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding()
                Spacer()
            } else {
                // If there are items, show them in a styled list
                List {
                    Section(header: Text("Cart Items")) {
                        ForEach(cartViewModel.items) { item in
                            CartItemRow(item: item)
                                .padding(.vertical, 5)
                                .listRowBackground(Color.clear)
                        }
                        .onDelete(perform: cartViewModel.remove)
                    }
                }
                .listStyle(InsetGroupedListStyle()) // iOS 14+ friendly
                .background(Color(.systemGroupedBackground))
                
                // Checkout Button with Total
                HStack {
                    Spacer()
                    Button(action: handleCheckout) {
                        HStack {
                            Text("Checkout")
                                .font(.headline)
                                .padding(.horizontal, 10)
                            Spacer()
                            Text("Total: $\(cartViewModel.totalCost, specifier: "%.2f")")
                                .font(.headline)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(cartViewModel.items.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .disabled(cartViewModel.items.isEmpty)
                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle("My Cart")
    }
    
    /// Example placeholder for checkout logic
    private func handleCheckout() {
        // e.g., show an alert, or proceed to payment screen
        print("Checkout tapped. Total is \(cartViewModel.totalCost).")
    }
}

// MARK: - Styled Row for Each Cart Item
struct CartItemRow: View {
    let item: MenuItem
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // If your MenuItem has an imageName, display it
            if let imageName = item.imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            } else {
                // Fallback system icon
                Image(systemName: "cup.and.saucer.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.red)
            }
            
            // Display item name and price
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                Text("$\(item.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color(.systemGray4), radius: 2, x: 0, y: 1)
        )
    }
}

// MARK: - Preview
struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            let testCartViewModel = CartViewModel()
            CartView(cartViewModel: testCartViewModel)
        }
    }
}
