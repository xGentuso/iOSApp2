// iOSApp1App.swift
import SwiftUI

@main
struct iOSApp1App: App {
    @StateObject var authViewModel = AuthViewModel()  // Initialize AuthViewModel once
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.isLoggedIn {
                MainTabView(authViewModel: authViewModel)
            } else {
                LoginView(authViewModel: authViewModel)
            }
        }
    }
}
