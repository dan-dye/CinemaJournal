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
    //Models
    @StateObject private var model: AuthenticationModel = AuthenticationModel()
    
    //View Models
    @StateObject private var authViewModel: AuthViewModel = AuthViewModel()
    
    //Error handling variables
    @State private var error: String = ""
    @State private var errorShown: Bool = false
    
    //Tracks logged in status
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        //If user is already logged in, redirect to Home.
        if isLoggedIn {
            HomeView()
        }
        else {
            List {
                Text("Log In")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                //Email entry
                TextField("Email", text: $model.email) {
                    
                }
                .autocapitalization(.none)
                .padding()
                .background((Color.gray.opacity(0.2)))
                .cornerRadius(10)
                //Password entry
                SecureField("Password", text: $model.password) {
                    
                }
                .padding()
                .background((Color.gray.opacity(0.2)))
                .cornerRadius(10)
                Button {
                    //Checks if email or password is empty, or email is not valid form.
                    if authViewModel.validateUser(model: model) {
                        Task {
                            do {
                                //Firebase login
                                try await authViewModel.login(email: model.email, password: model.password)
                            } catch {
                                //Errors from Firebase
                                self.error = error.localizedDescription
                                self.errorShown = true
                            }
                        }
                    }
                    else {
                        //Display front end errors
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
                    //Error display alert
                    Alert(title: Text("Error"), message: Text(error), dismissButton: .default(Text("OK")))
                }
            }

        }
    }
    
}
