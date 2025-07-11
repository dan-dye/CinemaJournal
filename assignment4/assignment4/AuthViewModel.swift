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
    func register(email: String, password: String) async throws {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
        } catch {
            throw error
        }
    }
    
    //Login user in Firebase
    func login(email: String, password: String) async throws {
        do{
            try await Auth.auth().signIn(withEmail: email, password: password)
        } catch {
            throw error
        }
    }
    
    //Front end validation
    //Validate if email or password is empty, validate if email form is valid, and password is correct length.
    func validateUser(model: AuthenticationModel) -> Bool {
        guard !model.email.isEmpty, !model.password.isEmpty else {
                model.errorMessage = "Email and password cannot be empty."
                return false
            }

            guard isValidEmail(model.email) else {
                model.errorMessage = "Please enter a valid email address."
                return false
            }
        
            guard isValidPassword(model.password) else {
                model.errorMessage = "Password must be greater than 6 characters."
                return false
            }
        return true
    }
    
    //Helper function for validating email format using regex comparison.
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    //Helper function for validating password is correct length.
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
    
    //Aggregate function that runs validateUser and also verifies is password and confirm password match.
    func validateNewUser(model: AuthenticationModel) -> Bool {
        guard model.password == model.confirmPassword else {
            model.errorMessage = "Passwords do not match."
            return false
        }
        
        guard validateUser(model: model) else {
            return false
        }
        
        return true
    }
    
}
