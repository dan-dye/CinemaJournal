//
//  ReviewDetail.swift
//  assignment4
//
//  Created by Daniel Dye on 7/4/25.
//

import SwiftUI

struct ReviewDetail: View {
    var review : ReviewModel
    @State var movie = MovieModel()
    @State private var showDeleteAlert = false
    @State private var reviewVM = ReviewViewModel()
    @State private var isMovieLoaded = false
    @Binding var path: [Route]
    
    var navigationHeader: String {
            let year = movie.release_date?.prefix(4) ?? "Unknown"
            return "\(movie.title) (\(year))"
        }
    
    var body: some View {
        List {
            HStack {
                Spacer()
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
                    HStack {
                        ForEach(0..<Int(review.rating), id: \.self) { _ in
                            Image(systemName: "star.fill")
                        }

                        // Empty stars
                        ForEach(0..<(5 - Int(review.rating)), id: \.self) { _ in
                            Image(systemName: "star")
                        }
                    }
                }
                
                
             
                
                Text(review.content)
                Button("Edit") {
                    path.append(.edit(review, movie))
                }
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                Button("Delete") {
                    showDeleteAlert = true
                }
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(10)
            }
            .padding()

            Section(header: Text("Information")) {
                Text("Release: " + (movie.release_date ?? "Unknown"))
                Text(movie.overview)
            }

        }
        .onAppear {
            Task {
                movie = try! await MovieService.shared.findMovie(query: review.movie)
                isMovieLoaded = true
            }
        }
        .navigationTitle(isMovieLoaded ? navigationHeader : "")
        .navigationBarTitleDisplayMode(.large)
        .alert("Are you sure you want to delete?", isPresented: $showDeleteAlert) {
                    Button("Delete", role: .destructive) {
                        Task {
                            await reviewVM.deleteReview(review: review)
                            path = [.myReviews]
                        }
                    }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Deleted reviews cannot be recovered.")
                }
        
    }
}


