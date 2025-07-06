//
//  MyReviewsView.swift
//  assignment4
//
//  Created by Daniel Dye on 7/4/25.
//

import SwiftUI
import FirebaseAuth

/*My Reviews
 Displays users saved reviews. Reviews stored in Firebase.
 */

struct MyReviewsView: View {
    //Current user
    let user = Auth.auth().currentUser
    
    //Tracks if a user is logged in
    @State private var isLoggedIn: Bool = true
    
    //View models
    @StateObject var myReviews = ReviewViewModel()
    
    //Parameters
    @Binding var path: [Route]
    
    var body: some View {

        List {
            //Lists all reviews
            ForEach(myReviews.reviews) { review in
                Button(review.movieTitle!) {
                    path.append(.reviewDetails(review))
                }
            }
        }
        .onAppear {
            //Fetches user's reviews from Firebase
            myReviews.fetchReviews(user: user?.uid ?? "")
        }
        .navigationTitle("My Reviews")
    }
}

