//
//  EditView.swift
//  assignment4
//
//  Created by Daniel Dye on 7/5/25.
//

import SwiftUI
import FirebaseAuth

/*Edit Review
 Page for editing the text content and rating of reviews.*/

struct EditView: View {
    //Passed parameters
    @State var review: ReviewModel
    @State var movie: MovieModel
    @Binding var path: [Route]
    
    //Current user
    let user = Auth.auth().currentUser
    
    //Bindings for review content and rating
    @State private var reviewText: String = ""
    @State private var rating: Double = 5
    
    //View Models
    @State private var reviewVM = ReviewViewModel()

    var body: some View {
        VStack {
            //Button stores changed content and rating and updates the saved review.
            Button {
                Task {
                    review.content = reviewText
                    review.rating = Int(rating)
                    review.movie = movie.id
                    review.user = user!.uid
                    let year = movie.release_date?.prefix(4) ?? "Unknown" //Get year from date
                    let title = "\(movie.title) (\(year))" //Title + year for easier id in search
                    review.movieTitle = title
                    await reviewVM.editReview(review: review)
                    path = [.reviewDetails(review)]
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
        }
        .padding()
        .onAppear() {
            //Load exisiting rating and review content for editing.
            reviewText = review.content
            rating = Double(review.rating)
            
        }
    }
}


