//
//  ContentView.swift
//  assignment4
//
//  Created by Daniel Dye on 6/22/25.
//

import SwiftUI
import FirebaseAuth

/*Starting View
 Prompts user to sign up if they are not logged in, else redirects them to Home.
 */

struct ContentView: View {
    //View Models
    @StateObject private var model: AuthenticationModel = AuthenticationModel()
    @StateObject private var authViewModel: AuthViewModel = AuthViewModel()
    
    //Error handling variables
    @State private var error: String = ""
    @State private var errorShown: Bool = false
    
    //Holds if users is already logged in
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        //User logged in
        if isLoggedIn {
            HomeView()
        }
        //User is not logged in
        else {
            NavigationStack {
                List {
                    Text("Sign Up")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                    TextField("Email", text: $model.email) {
                        
                    }
                        .autocapitalization(.none)
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
                        //Checks if email is valid, email or password is blank, or passwords don't match.
                        if authViewModel.validateNewUser(model: model) {
                            Task {
                                do {
                                    //Firebase register
                                    try await authViewModel.register(email: model.email, password: model.password)
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
                        Text("Register With Email")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .alert(isPresented: $errorShown) {
                        //Alert with login error messages
                        Alert(title: Text("Error"), message: Text(error), dismissButton: .default(Text("OK")))
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
                //Sets up listener for logged in status
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




