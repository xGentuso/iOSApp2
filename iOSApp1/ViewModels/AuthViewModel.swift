// AuthViewModel.swift
import SwiftUI

class AuthViewModel: ObservableObject {
    
    @Published var currentUser: User? = nil
    @Published var isLoggedIn: Bool = false
    
    private let userDefaultsKey = "AppUser"
    
    init() {
        loadUser()
    }
    
    /// Sign up a new user and save to UserDefaults
    func signUp(username: String, password: String) -> Bool {
        // Check if a user with that username already exists
        if let existingUser = loadUserFromDefaults(),
           existingUser.username.lowercased() == username.lowercased() {
            // Username is taken
            return false
        }
        
        // Otherwise, create a new user
        let newUser = User(username: username, password: password)
        saveUserToDefaults(newUser)
        currentUser = newUser
        isLoggedIn = true
        return true
    }
    
    /// Log in with existing credentials
    func login(username: String, password: String) -> Bool {
        guard let savedUser = loadUserFromDefaults() else {
            return false // No user found
        }
        
        // Check if credentials match
        if savedUser.username.lowercased() == username.lowercased() &&
           savedUser.password == password {
            currentUser = savedUser
            isLoggedIn = true
            return true
        } else {
            return false
        }
    }
    
    /// Log out
    func logout() {
        currentUser = nil
        isLoggedIn = false
        print("User logged out") // For debugging
    }
    
    // MARK: - UserDefaults Persistence
    
    private func saveUserToDefaults(_ user: User) {
        do {
            let data = try JSONEncoder().encode(user)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            print("Error encoding user: \(error)")
        }
    }
    
    private func loadUserFromDefaults() -> User? {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            return nil
        }
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            return user
        } catch {
            print("Error decoding user: \(error)")
            return nil
        }
    }
    
    private func loadUser() {
        if let savedUser = loadUserFromDefaults() {
            currentUser = savedUser
            isLoggedIn = true
        }
    }
}
