//
//  CoffeeOrderView.swift
//  TimHortonsApp
//
//  Created by ryan mota on 2025-01-23.
//

import SwiftUI

class CoffeeOrderViewModel: ObservableObject {
    @Published var orders: [CoffeeOrder] = []
    
    init() {
        loadOrders()
    }
    
    /// Adds a new coffee order, then saves the updated list to UserDefaults.
    func addOrder(_ order: CoffeeOrder) {
        orders.append(order)
        saveOrders()
    }
    
    /// Removes an order from the list at the specified index set, then saves.
    func removeOrder(at offsets: IndexSet) {
        orders.remove(atOffsets: offsets)
        saveOrders()
    }
    
    /// Encodes orders into JSON and saves them in UserDefaults.
    func saveOrders() {
        do {
            let data = try JSONEncoder().encode(orders)
            UserDefaults.standard.set(data, forKey: "SavedOrders")
        } catch {
            print("Error encoding orders: \(error)")
        }
    }
    
    /// Loads orders from UserDefaults if any exist, decoding from JSON.
    func loadOrders() {
        if let data = UserDefaults.standard.data(forKey: "SavedOrders") {
            do {
                let decoded = try JSONDecoder().decode([CoffeeOrder].self, from: data)
                orders = decoded
            } catch {
                print("Error decoding orders: \(error)")
            }
        }
    }
}
