import SwiftUI

class CartViewModel: ObservableObject {
    @Published var items: [MenuItem] = [] {
        didSet {
            saveCart()
        }
    }
    
    private let cartKey = "cartItems"
    
    init() {
        loadCart()
    }
    
    // Add item to cart
    func add(_ item: MenuItem) {
        items.append(item)
    }
    
    // Remove item(s) from cart
    func remove(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    // Calculate total cost
    var totalCost: Double {
        items.reduce(0) { $0 + $1.price }
    }
    
    // Save cart items to UserDefaults
    private func saveCart() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(items)
            UserDefaults.standard.set(data, forKey: cartKey)
        } catch {
            print("Error encoding cart items: \(error)")
        }
    }
    
    // Load cart items from UserDefaults
    private func loadCart() {
        guard let data = UserDefaults.standard.data(forKey: cartKey) else {
            return // No data to load
        }
        do {
            let decoder = JSONDecoder()
            let savedItems = try decoder.decode([MenuItem].self, from: data)
            self.items = savedItems
        } catch {
            print("Error decoding cart items: \(error)")
        }
    }
}
