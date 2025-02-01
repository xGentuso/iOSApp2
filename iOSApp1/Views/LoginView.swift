// LoginView.swift
import SwiftUI

struct LoginView: View {
    @ObservedObject var authViewModel: AuthViewModel
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isSignUpMode: Bool = false
    
    // For showing alerts if login/signup fails
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            // MARK: - Background
            LinearGradient(
                gradient: Gradient(colors: [Color.white, Color.red.opacity(0.1)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // (Optional) App Logo or Cup Icon
                Image(systemName: "cup.and.saucer.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.red)
                    .padding(.top, 60)
                
                // Title
                Text(isSignUpMode ? "Create an Account" : "Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                
                // Subtitle
                Text(isSignUpMode
                     ? "Join us for your daily coffee run."
                     : "Log in to continue.")
                    .foregroundColor(.primary)
                    .font(.callout)
                
                // MARK: - Form Fields
                VStack(spacing: 15) {
                    // Username
                    TextField("Username", text: $username)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.systemGray6))
                        )
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding(.horizontal, 40)
                    
                    // Password
                    SecureField("Password", text: $password)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.systemGray6))
                        )
                        .padding(.horizontal, 40)
                }
                
                // MARK: - Login/Sign Up Button
                Button(action: handleAuthAction) {
                    Text(isSignUpMode ? "Sign Up" : "Log In")
                        .font(.headline)
                        .padding()
                        .frame(minWidth: 180)
                        .background(Color.red.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 10)
                
                // Toggle between modes
                Button(action: { isSignUpMode.toggle() }) {
                    Text(isSignUpMode
                         ? "Already have an account? Log in"
                         : "Don't have an account? Sign up")
                        .underline()
                        .foregroundColor(.red)
                }
                .padding(.bottom, 40)
            }
            .padding(.horizontal)
        }
        .alert(alertMessage, isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
    // MARK: - Handle Auth Action
    private func handleAuthAction() {
        guard !username.isEmpty, !password.isEmpty else {
            alertMessage = "Please fill in both fields."
            showAlert = true
            return
        }
        
        if isSignUpMode {
            let success = authViewModel.signUp(username: username, password: password)
            if !success {
                alertMessage = "Username already exists. Try another."
                showAlert = true
            }
        } else {
            let success = authViewModel.login(username: username, password: password)
            if !success {
                alertMessage = "Invalid credentials. Please try again."
                showAlert = true
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authViewModel: AuthViewModel())
    }
}
