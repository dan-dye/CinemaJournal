//
//  CreateReviewView.swift
//  assignment4
//
//  Created by Daniel Dye on 7/5/25.
//

import SwiftUI
import FirebaseAuth

struct CreateReviewView: View {
    var movie: MovieModel
    
    let user = Auth.auth().currentUser
    @State private var reviewText: String = ""
    @State private var rating: Double = 5
    @State private var reviewVM = ReviewViewModel()
    @State private var review: ReviewModel = ReviewModel()
    @State private var goToDestination: Bool = false
    
    var body: some View {
        VStack {
            Button {
                Task {
                    review.content = reviewText
                    review.rating = Int(rating)
                    review.movie = movie.id
                    review.user = user!.uid
                    await reviewVM.saveReview(review: review)
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
            TextField("Review...", text: $reviewText,  axis: .vertical)
                .lineLimit(5...10)
            
            
        }
        .padding()
        .navigationDestination(isPresented: $goToDestination) {
            MyReviewsView()
        }
    }
}

