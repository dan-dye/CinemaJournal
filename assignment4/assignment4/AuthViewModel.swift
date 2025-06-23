//
//  AuthenticationController.swift
//  assignment4
//
//  Created by Daniel Dye on 6/22/25.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    
    //Register new user in Firebase
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error creating user: \(error)")
                return
            }
            print("User created successfully!")
        }
    }
    
    //Login user in Firebase
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error {
                print("Error logging in: \(error)")
                return
            }
            print("User created successfully!")
        }
    }
    
    
    
}
