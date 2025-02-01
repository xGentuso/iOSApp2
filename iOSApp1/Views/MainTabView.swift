import SwiftUI

struct MainTabView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @StateObject var coffeeOrderViewModel = CoffeeOrderViewModel()
    @StateObject var cartViewModel = CartViewModel()
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            // 0: HOME TAB
            NavigationStack {
                WelcomeView(viewModel: coffeeOrderViewModel, selectedTab: $selectedTab, logoutAction:{
                    authViewModel.logout() // Passes the logout function
                })
            }
            .tag(0)
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            // 1: ORDERS TAB
            NavigationStack {
                OrderListView(viewModel: coffeeOrderViewModel)
            }
            .tag(1)
            .tabItem {
                Label("Orders", systemImage: "cup.and.saucer.fill")
            }
            
            // 2: MENU TAB
            NavigationStack {
                MenuView(cartViewModel: cartViewModel)
            }
            .tag(2)
            .tabItem {
                Label("Menu", systemImage: "list.bullet")
            }
            
            // 3: CART TAB
            // 3: CART TAB
            NavigationStack {
                CartView(cartViewModel: cartViewModel)
            }
            .tag(3)
            .tabItem {
                Label("Cart", systemImage: "cart.fill")
            }
            .badge(cartViewModel.items.isEmpty ? 0 : cartViewModel.items.count)

            
        }
    }
}

// MARK: - Preview
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(authViewModel: AuthViewModel())
    }
}
