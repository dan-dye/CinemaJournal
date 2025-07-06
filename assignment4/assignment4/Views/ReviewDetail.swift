//
//  ReviewDetail.swift
//  assignment4
//
//  Created by Daniel Dye on 7/4/25.
//

import SwiftUI

/*Review Detail
 Displays a single review information.
 */

struct ReviewDetail: View {
    //Parameters
    var review : ReviewModel
    @Binding var path: [Route]
    
    //Holds new movie object after fetched using Movie ID tied to review
    @State var movie = MovieModel()
    
    //Deletion warning toggle
    @State private var showDeleteAlert = false
    
    //View models
    @State private var reviewVM = ReviewViewModel()
    
    //Used to signal navigation title to load once the title for the movie has been gathered
    @State private var isMovieLoaded = false
    
    //Fixes error. Builds title from optional date to prevent unwrapping within the view builder.
    var navigationHeader: String {
            let year = movie.release_date?.prefix(4) ?? "Unknown"
            return "\(movie.title) (\(year))"
        }
    
    var body: some View {
        List {
            HStack {
                Spacer()
                //Poster
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200/" + (movie.poster_path ?? ""))) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 200) 
                .cornerRadius(10)
                Spacer()
            }
            .padding()
            

            Section(header: Text("Review")) {
                HStack {
                    Text("Your Rating: ")
                    //Star rating display
                    HStack {
                        //Full stars
                        ForEach(0..<Int(review.rating), id: \.self) { _ in
                            Image(systemName: "star.fill")
                        }
                        // Empty stars
                        ForEach(0..<(5 - Int(review.rating)), id: \.self) { _ in
                            Image(systemName: "star")
                        }
                    }
                }
                //Review text
                Text(review.content)
                
                //Buttons for editing or deleting the review
                Button("Edit") {
                    path.append(.edit(review, movie))
                }
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                
                Button("Delete") {
                    showDeleteAlert = true //Displays deletion warning
                }
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(10)
            }
            .padding()

            //Movie information
            Section(header: Text("Information")) {
                Text("Release: " + (movie.release_date ?? "Unknown"))
                Text(movie.overview)
            }

        }
        .onAppear {
            Task {
                //Fetches movie object based on the saved movie id of the review.
                movie = try! await MovieService.shared.findMovie(query: review.movie)
                isMovieLoaded = true
            }
        }
        .navigationTitle(isMovieLoaded ? navigationHeader : "") //Hides title if movie hasn't loaded yet.
        .navigationBarTitleDisplayMode(.large)
        //Deletion warning
        .alert("Are you sure you want to delete?", isPresented: $showDeleteAlert) {
                    Button("Delete", role: .destructive) {
                        Task {
                            //Firebase delete
                            await reviewVM.deleteReview(review: review)
                            //Navigate back to My Reviews once deleted
                            path = [.myReviews]
                        }
                    }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Deleted reviews cannot be recovered.")
                }
        
    }
}


