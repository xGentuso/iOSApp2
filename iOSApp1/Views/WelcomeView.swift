//
//  WelcomeView.swift
//  TimHortonsApp
//
//  Created by ryan mota on 2025-01-23.
//

import SwiftUI

struct WelcomeView: View {
    @ObservedObject var viewModel: CoffeeOrderViewModel
    @Binding var selectedTab: Int  // Binding to the parent's selectedTab
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.white, Color.red.opacity(0.1)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Welcome to Tim Hortons App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                
                Text("Your daily coffee run made simpler.")
                    .font(.title3)
                    .padding(.horizontal, 30)
                
                Image(systemName: "cup.and.saucer.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                    .padding(.vertical, 10)
                
                // MARK: - Switch Tab to the Orders tab
                Button {
                    selectedTab = 1  // Switch to the Orders tab
                } label: {
                    Text("View Orders")
                        .font(.headline)
                        .padding()
                        .frame(minWidth: 180)
                        .background(Color.red.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 10)
            }
            .padding()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a dummy binding for the tab in previews
        WelcomeView(viewModel: CoffeeOrderViewModel(), selectedTab: .constant(0))
    }
}
