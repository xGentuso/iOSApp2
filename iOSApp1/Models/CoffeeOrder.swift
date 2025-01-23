//
//  CoffeeOrder.swift
//  TimHortonsApp
//
//  Created by ryan mota on 2025-01-23.
//

import Foundation

struct CoffeeOrder: Identifiable, Codable {
    let id: UUID
    var personName: String
    var coffeeType: String
    var size: String
    var sugar: Int
    var cream: Int
    
    init(id: UUID = UUID(),
         personName: String,
         coffeeType: String,
         size: String,
         sugar: Int,
         cream: Int) {
        self.id = id
        self.personName = personName
        self.coffeeType = coffeeType
        self.size = size
        self.sugar = sugar
        self.cream = cream
    }
}

