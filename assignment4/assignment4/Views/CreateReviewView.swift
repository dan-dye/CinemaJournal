//
//  CreateReviewView.swift
//  assignment4
//
//  Created by Daniel Dye on 7/5/25.
//

import SwiftUI
import FirebaseAuth

struct CreateReviewView: View {
    @State var movie: MovieModel
    
    let user = Auth.auth().currentUser
    @State private var reviewText: String = ""
    @State private var rating: Double = 5
    @State private var reviewVM = ReviewViewModel()
    @State private var review: ReviewModel = ReviewModel()
    @Binding var path: [Route]
    
    var body: some View {
        VStack {
            Button {
                Task {
                    review.content = reviewText
                    review.rating = Int(rating)
                    review.movie = movie.id
                    review.user = user!.uid
                    let year = movie.release_date?.prefix(4) ?? "Unknown"
                    let title = "\(movie.title) (\(year))"
                    review.movieTitle = title
                    await reviewVM.saveReview(review: review)
                    path = [.myReviews]
                }

            } label: {
                Text("Submit Review")
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            HStack {
                Text("Rating: " + String(Int(rating)))
                Slider(value: $rating, in: 1...5, step: 1)
            }
            .padding()
            TextEditor(text: $reviewText)
                .background(Color.gray.opacity(0.2))
                .scrollContentBackground(.hidden)
            
        }
        .padding()
    }
}

