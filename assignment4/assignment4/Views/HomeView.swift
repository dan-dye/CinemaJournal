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
    let user = Auth.auth().currentUser
    @State var isLoggedIn: Bool = true
    
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
                    NavigationLink("Add a Review") {
                        MovieSearchView()
                    }
                    Spacer()
                    Button("Logout") {
                        try? Auth.auth().signOut()
                    }
                }
                .navigationTitle(user?.email ?? "user");
            }.onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
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
