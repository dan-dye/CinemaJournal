//
//  CreateReviewView.swift
//  assignment4
//
//  Created by Daniel Dye on 7/5/25.
//

import SwiftUI
import FirebaseAuth

/*Create Review
 Allows user to set content and rating for a movie and save it as a new review.
 */

struct CreateReviewView: View {
    //Passed parameters
    @State var movie: MovieModel
    @State private var review: ReviewModel = ReviewModel()
    @Binding var path: [Route] //For navigation
    
    //View Models
    @State private var reviewVM = ReviewViewModel()
    
    //Current user
    let user = Auth.auth().currentUser
    
    //Bindings for review content and rating
    @State private var reviewText: String = ""
    @State private var rating: Double = 5

    
    var body: some View {
        List {
            //Saves the current movie details and entered review text and rating to a new review.
            Button {
                Task {
                    review.content = reviewText
                    review.rating = Int(rating)
                    review.movie = movie.id
                    review.user = user!.uid
                    let year = movie.release_date?.prefix(4) ?? "Unknown" //Get year from date
                    let title = "\(movie.title) (\(year))" //Title + year for easier id in search
                    review.movieTitle = title
                    await reviewVM.saveReview(review: review)
                    path = [.myReviews] //Navigate back to My Reviews when finished
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
                //Select a rating from 1-5
                Slider(value: $rating, in: 1...5, step: 1)
            }
            .padding()
            //Text editor for review text content.
            TextEditor(text: $reviewText)
                .background(Color.gray.opacity(0.2))
                .scrollContentBackground(.hidden)
                .frame(minHeight: 180)
            
        }
        .padding()
    }
}

