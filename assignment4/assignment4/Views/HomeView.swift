//
//  TestView.swift
//  assignment4
//
//  Created by Daniel Dye on 6/22/25.
//

import SwiftUI
import FirebaseAuth

enum Route: Hashable {
    case myReviews
    case movieSearch
    case movieDetails(MovieModel)
    case reviewDetails(ReviewModel)
    case edit(ReviewModel, MovieModel)
    case createReview(MovieModel)
}
//Simulates the landing page after authentication in final app
struct HomeView: View {
    @State private var user = Auth.auth().currentUser
    @State private var isLoggedIn: Bool = true
    @State private var path: [Route] = []
    
    var body: some View {
        if(!isLoggedIn) {
            ContentView()
        }
        else {
            NavigationStack(path: $path) {
                List {
                    Button("My Reviews") {
                        path.append(.myReviews)
                    }
                    Button("Add a Review") {
                        path.append(.movieSearch)
                    }
                    Spacer()
                    Text("Account: " + (user?.email ?? "default"))
                        .font(.system(size: 14))
                    Button("Logout") {
                        try? Auth.auth().signOut()
                    }
                }
                .navigationTitle("CineJournal")
                .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .myReviews:
                            MyReviewsView(path: $path)
                        case .movieSearch:
                            MovieSearchView(path: $path)
                        case .movieDetails(let movie):
                            MovieDetails(movie: movie, path: $path)
                        case .reviewDetails(let review):
                            ReviewDetail(review: review, path: $path)
                        case .edit(let review, let movie):
                            EditView(review: review, movie: movie, path: $path)
                        case .createReview(let movie):
                            CreateReviewView(movie: movie, path: $path)
                        }
                    }
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
