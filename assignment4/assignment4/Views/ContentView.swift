//
//  ContentView.swift
//  assignment4
//
//  Created by Daniel Dye on 6/22/25.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @StateObject private var model: AuthenticationModel = AuthenticationModel()
    @StateObject private var authViewModel: AuthViewModel = AuthViewModel()
    //Checks if users is already logged in
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        //User logged in
        if isLoggedIn {
            HomeView()
        }
        //User is not logged in
        else {
            NavigationStack {
                Group {
                    Text("Sign Up")
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
                    SecureField("Confirm Password", text: $model.confirmPassword) {
                        
                    }
                        .padding()
                        .background((Color.gray.opacity(0.2)))
                        .cornerRadius(10)
                    Button {
                        if(model.password == model.confirmPassword) {
                            authViewModel.register(email: model.email, password: model.password)
                            
                        }
                        else {
                            print("Passwords do not match")
                        }
                    } label: {
                        Text("Register With Email")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    //Link for login instead
                    NavigationLink {
                        LoginView()
                    } label: {
                        Text("Already have an account? Login")
                    }
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
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
            .padding()

        }
            
    }
}







#Preview {
    ContentView()
}
