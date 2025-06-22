//
//  AuthenticationView.swift
//  assignment4
//
//  Created by Daniel Dye on 6/22/25.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var model: AuthenticationModel = AuthenticationModel()
    @EnvironmentObject private var authViewModel: AuthViewModel
    var body: some View {
        NavigationStack {
            VStack {
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
                
            }
                .padding()
                .navigationTitle("Register")
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
            .padding()
            Spacer()
        }

    }
}

#Preview {
    RegisterView()
}
