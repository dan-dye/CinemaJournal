//
//  TestView.swift
//  assignment4
//
//  Created by Daniel Dye on 6/22/25.
//

import SwiftUI
import FirebaseAuth

//Simulates the landing page after authentication in final app
struct HomeView: View {
    @State private var user = Auth.auth().currentUser
    @State private var isLoggedIn: Bool = true
    
    var body: some View {
        if(!isLoggedIn) {
            ContentView()
        }
        else {
            NavigationStack {
                List {
                    NavigationLink("My Reviews") {
                        MyReviewsView()
                    }
                    .padding()
                    NavigationLink("Add a Review") {
                        MovieSearchView()
                    }
                    .padding()
                    Spacer()
                    Text("Account: " + (user?.email ?? "default"))
                        .font(.system(size: 14))
                    Button("Logout") {
                        try? Auth.auth().signOut()
                    }
                }
                .navigationTitle("CineJournal");
            }.onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        self.user = user
                        isLoggedIn = true
                    }
                    else {
                        isLoggedIn = false
                    }
                }
            }
            
        }
    }
}
#Preview {
    HomeView()
}
