import SwiftUI
import Combine
import Foundation  

// MARK: - CoffeeOrderViewModel

class CoffeeOrderViewModel: ObservableObject {
    @Published var orders: [CoffeeOrder] = []

    private let userDefaultsKey = "CoffeeOrders"
    
    init() {
        loadOrders()
    }
    
    func addOrder(_ order: CoffeeOrder) {
        orders.append(order)
        saveOrders()
    }
    
    func removeOrder(at offsets: IndexSet) {
        orders.remove(atOffsets: offsets)
        saveOrders()
    }
    
    // MARK: - Persistence

    private func saveOrders() {
        do {
            let data = try JSONEncoder().encode(orders)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            print("Error encoding orders: \(error)")
        }
    }
    
    private func loadOrders() {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            return
        }
        do {
            let decodedOrders = try JSONDecoder().decode([CoffeeOrder].self, from: data)
            orders = decodedOrders
        } catch {
            print("Error decoding orders: \(error)")
        }
    }
}
