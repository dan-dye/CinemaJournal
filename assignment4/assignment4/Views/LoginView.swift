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
    @State private var isLoggedIn: Bool = false
    var body: some View {
        if isLoggedIn {
            TestView()
        }
        else {
            Group {
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
                    authViewModel.login(email: model.email, password: model.password)
                } label: {
                    Text("Login With Email")
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            //Listener for login state
            .onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        isLoggedIn = true
                    }
                }
            }
        }
    }
    
}
