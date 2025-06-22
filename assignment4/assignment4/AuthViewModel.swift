//
//  AuthenticationController.swift
//  assignment4
//
//  Created by Daniel Dye on 6/22/25.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    
    @Published var userEmail: String?
    @Published var isLoggedIn: Bool = false
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error creating user: \(error)")
                return
            }
            print("User created successfully!")
            self.isLoggedIn = true
            self.userEmail = result?.user.email
        }
    }
    
    
    
}
