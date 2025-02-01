import SwiftUI

struct MenuView: View {
    @ObservedObject var cartViewModel: CartViewModel
    
    let menuItems: [MenuItem] = [
        // ☕ Coffee & Hot Drinks
        MenuItem(name: "Original Blend Coffee", description: "Smooth and rich classic brew.", price: 1.99, imageName: "coffee_icon"),
        MenuItem(name: "Dark Roast Coffee", description: "Full-bodied roast with a cocoa finish.", price: 2.29, imageName: "coffee_icon"),
        MenuItem(name: "Double Double", description: "Two creams, two sugars – a Canadian classic.", price: 2.49, imageName: "coffee_icon"),
        MenuItem(name: "French Vanilla", description: "Creamy and smooth vanilla-flavored coffee.", price: 2.99, imageName: "coffee_icon"),
        MenuItem(name: "Hot Chocolate", description: "Rich and creamy classic hot chocolate.", price: 2.79, imageName: "hot_chocolate_icon"),
        MenuItem(name: "Steeped Tea", description: "Signature steeped tea, bold and flavorful.", price: 1.99, imageName: "tea_icon"),
        MenuItem(name: "London Fog", description: "Earl Grey tea with steamed milk and vanilla.", price: 3.49, imageName: "tea_icon"),
        
        // 🍩 Baked Goods & Donuts
        MenuItem(name: "Boston Cream Donut", description: "Chocolate-frosted donut with creamy filling.", price: 1.29, imageName: "donut_icon"),
        MenuItem(name: "Honey Cruller", description: "Soft and airy honey-glazed donut.", price: 1.29, imageName: "donut_icon"),
        MenuItem(name: "Apple Fritter", description: "Glazed donut with cinnamon apple chunks.", price: 1.49, imageName: "donut_icon"),
        MenuItem(name: "Timbits (10-pack)", description: "Bite-sized donut holes in assorted flavors.", price: 2.79, imageName: "donut_icon"),
        MenuItem(name: "Blueberry Muffin", description: "Soft and fluffy with real blueberries.", price: 1.99, imageName: "muffin_icon"),
        
        // 🥯 Breakfast & Sandwiches
        MenuItem(name: "Bagel with Cream Cheese", description: "Toasted bagel with a spread of cream cheese.", price: 2.99, imageName: "bagel_icon"),
        MenuItem(name: "Bacon & Egg Sandwich", description: "Egg, bacon, and cheese on a toasted bun.", price: 3.99, imageName: "sandwich_icon"),
        MenuItem(name: "Sausage Breakfast Wrap", description: "Scrambled eggs, sausage, and cheese in a wrap.", price: 4.49, imageName: "wrap_icon"),
        
        // 🥤 Cold Drinks
        MenuItem(name: "Iced Coffee", description: "Sweet and refreshing chilled coffee.", price: 2.99, imageName: "iced_coffee_icon"),
        MenuItem(name: "Iced Capp", description: "Creamy frozen coffee blended to perfection.", price: 3.99, imageName: "iced_capp_icon"),
        MenuItem(name: "Frozen Lemonade", description: "Tangy and refreshing frozen lemonade.", price: 2.49, imageName: "lemonade_icon")
    ]
    
    var body: some View {
        NavigationView { // Ensure it's inside a NavigationView
            ScrollView { // Enable scrolling
                LazyVStack { // Efficient rendering for large lists
                    ForEach(menuItems) { item in
                        HStack {
                            // Display item image
                            if let imageName = item.imageName {
                                Image(imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            } else {
                                Image(systemName: "cup.and.saucer.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.red)
                            }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text("$\(item.price, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                            }
                            
                            Spacer()
                            
                            // Add to Cart Button
                            Button(action: {
                                cartViewModel.add(item)
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Menu")
        }
    }
}

// Preview
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(cartViewModel: CartViewModel())
    }
}
