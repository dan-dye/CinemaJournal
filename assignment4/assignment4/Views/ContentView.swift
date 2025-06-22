//
//  ContentView.swift
//  assignment4
//
//  Created by Daniel Dye on 6/22/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel: AuthViewModel = AuthViewModel()
    var body: some View {
        if(authViewModel.isLoggedIn) {
            Text("You're logged in!")
        }
        else {
            NavigationStack {
                Spacer()
                VStack {
                    NavigationLink ("Sign In") {
                        SignInView().environmentObject(authViewModel)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .padding()
                    .cornerRadius(10)
                    .font(.headline)
                    NavigationLink ("Register") {
                        RegisterView()
                            .environmentObject(authViewModel)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .padding()
                    .cornerRadius(10)
                    .font(.headline)
                }
                .navigationTitle("Sign In or Register")
                Spacer()
                Spacer()
            }

        }
        
    }
}

#Preview {
    ContentView()
}
