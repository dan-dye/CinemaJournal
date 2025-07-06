//
//  TestView.swift
//  assignment4
//
//  Created by Daniel Dye on 6/22/25.
//

import SwiftUI
import FirebaseAuth

//Routes for NavigationStack path variable
enum Route: Hashable {
    case myReviews
    case movieSearch
    case movieDetails(MovieModel)
    case reviewDetails(ReviewModel)
    case edit(ReviewModel, MovieModel)
    case createReview(MovieModel)
}

/*Home Screen
 Users can select to add a new review, look at their current reviews, or log out of their account.
 */

struct HomeView: View {
    //Get current user
    @State private var user = Auth.auth().currentUser
    //Track if user is logged in
    @State private var isLoggedIn: Bool = true
    //Path variable for NavigationStack routing
    @State private var path: [Route] = []
    
    var body: some View {
        //If not logged in, take back to the Sign Up screen.
        if(!isLoggedIn) {
            ContentView()
        }
        else {
            NavigationStack(path: $path) {
                List {
                    Section(header: Text("Reviews")) {
                        //Loads users reviews
                        Button("My Reviews") {
                            path.append(.myReviews)
                        }
                        //Allows user to search and review a new movie.
                        Button("Add a Review") {
                            path.append(.movieSearch)
                        }
                    }
                    
                    Section(header: Text("Account")) {
                        Text("Account: " + (user?.email ?? "default"))
                            .font(.system(size: 14))
                        //Logs user out of their account and takes them back to the Sign-up screen
                        Button("Logout") {
                            try? Auth.auth().signOut()
                        }
                    }
                    
                }
                .navigationTitle("CineJournal")
                //Enum route destinations
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
                .onAppear {
                    //Sets up listener for logged in status
                    Auth.auth().addStateDidChangeListener { auth, user in
                        if user != nil {
                            self.user = user
                            isLoggedIn = true
                        }
                        else {
                            self.user = nil
                            isLoggedIn = false
                        }
                    }
                }
            }
        }
    }
}
