//
//  Homeview.swift
//  TimHortonsApp
//
//  Created by ryan mota on 2025-01-23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = CoffeeOrderViewModel()
    @State private var selectedTab: Int = 0  // 0 = Home, 1 = Orders, etc.
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            // HOME TAB
            NavigationStack {
                // Pass binding to selectedTab so we can change tabs from inside WelcomeView
                WelcomeView(viewModel: viewModel, selectedTab: $selectedTab)
            }
            .tag(0)
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            // ORDERS TAB
            NavigationStack {
                OrderListView(viewModel: viewModel)
            }
            .tag(1)
            .tabItem {
                Label("Orders", systemImage: "cup.and.saucer.fill")
            }
            // MARK: - Settings Tab (Optional)
            NavigationStack {
                VStack {
                    Text("Settings or other features")
                        .font(.headline)
                }
                .navigationTitle("Settings")
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
