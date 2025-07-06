//
//  MyReviewsView.swift
//  assignment4
//
//  Created by Daniel Dye on 7/4/25.
//

import SwiftUI
import FirebaseAuth

struct MyReviewsView: View {
    let user = Auth.auth().currentUser
    @State private var isLoggedIn: Bool = true
    @StateObject var myReviews = ReviewViewModel()
    @Binding var path: [Route]
    var body: some View {

        List {
            ForEach(myReviews.reviews) { review in
                Button(review.movieTitle!) {
                    path.append(.reviewDetails(review))
                }
            }
        }
        .onAppear {
            myReviews.fetchReviews(user: user?.uid ?? "")
        }
        .navigationTitle("My Reviews")
    }
}

