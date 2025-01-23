//
//  OrderRowView.swift
//  TimHortonsApp
//
//  Created by ryan mota on 2025-01-23.
//

import SwiftUI

struct OrderRowView: View {
    let order: CoffeeOrder
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // An icon or image to represent the order
            Image(systemName: "cup.and.saucer.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.red)
            
            // Main order details
            VStack(alignment: .leading, spacing: 4) {
                Text(order.personName)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("\(order.size) \(order.coffeeType)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("\(order.sugar) sugar, \(order.cream) cream")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color(.systemGray4), radius: 4, x: 0, y: 2)
        )
        .padding(.vertical, 4)
        .padding(.horizontal, 2)
    }
}

struct OrderRowView_Previews: PreviewProvider {
    static var previews: some View {
        // A sample order for preview purposes
        let sampleOrder = CoffeeOrder(
            personName: "Alice",
            coffeeType: "Latte",
            size: "Large",
            sugar: 2,
            cream: 1
        )
        
        OrderRowView(order: sampleOrder)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
