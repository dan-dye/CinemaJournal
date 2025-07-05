//
//  EditView.swift
//  assignment4
//
//  Created by Daniel Dye on 7/5/25.
//

import SwiftUI
import FirebaseAuth

struct EditView: View {
    @State var review: ReviewModel
    @State var movie: MovieModel
    let user = Auth.auth().currentUser
    @State private var reviewText: String = ""
    @State private var rating: Double = 5
    @State private var reviewVM = ReviewViewModel()
    @State private var goToDestination: Bool = false
    var body: some View {
        VStack {
            Button {
                Task {
                    review.content = reviewText
                    review.rating = Int(rating)
                    review.movie = movie.id
                    review.user = user!.uid
                    review.movieTitle = movie.title
                    await reviewVM.editReview(review: review)
                    goToDestination = true
                }
                
            } label: {
                Text("Submit Review")
            }
            HStack {
                Text("Rating: " + String(Int(rating)))
                Slider(value: $rating, in: 1...5, step: 1)
            }
            .padding()
            TextEditor(text: $reviewText)

            
            
            
        }
        .padding()
        .navigationDestination(isPresented: $goToDestination) {
            MyReviewsView()
        }
        .onAppear() {
            reviewText = review.content
            rating = Double(review.rating)
            
        }
    }
}


