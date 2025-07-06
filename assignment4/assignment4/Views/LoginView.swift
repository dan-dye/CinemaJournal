//
//  LoginView.swift
//  assignment4
//
//  Created by Daniel Dye on 6/22/25.
//

import SwiftUI
import FirebaseAuth

//Login page for existing accounts
struct LoginView: View {
    @StateObject private var model: AuthenticationModel = AuthenticationModel()
    @StateObject private var authViewModel: AuthViewModel = AuthViewModel()
    @State private var error: String = ""
    @State private var errorShown: Bool = false
    @State private var isLoggedIn: Bool = false
    var body: some View {
        if isLoggedIn {
            HomeView()
        }
        else {
            List {
                Text("Log In")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                TextField("Email", text: $model.email) {
                    
                }
                .padding()
                .background((Color.gray.opacity(0.2)))
                .cornerRadius(10)
                SecureField("Password", text: $model.password) {
                    
                }
                .padding()
                .background((Color.gray.opacity(0.2)))
                .cornerRadius(10)
                Button {
                    if authViewModel.validateUser(model: model) {
                        Task {
                            do {
                                try await authViewModel.login(email: model.email, password: model.password)
                            } catch {
                                self.error = error.localizedDescription
                                self.errorShown = true
                            }
                        }
                    }
                    else {
                        error = model.errorMessage
                        errorShown = true
                    }
                    
                    
                } label: {
                    Text("Login With Email")
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .alert(isPresented: $errorShown) {
                    Alert(title: Text("Error"), message: Text(error), dismissButton: .default(Text("OK")))
                }
            }

        }
    }
    
}
