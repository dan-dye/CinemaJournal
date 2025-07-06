//
//  MovieDetails.swift
//  assignment4
//
//  Created by Daniel Dye on 7/5/25.
//

import SwiftUI

/*Movie Details
 Displays the details of a movie pulled up in the MovieSearchView.
 Details fetched from TMDB API.
 */

struct MovieDetails: View {
    var movie: MovieModel
    @Binding var path: [Route]
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
            
            //Movie information
            Section(header: Text("Information")) {
                Text("Release: " + (movie.release_date ?? "Unknown"))
                Text(movie.overview)
            }
            
            //Create a new review for this movie.
            Button("New Review") {
                path.append(.createReview(movie))
            }
            .padding()
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)

        }
        .navigationTitle(movie.title + " (" + (movie.release_date?.prefix(4) ?? "Unknown") + ")")
        .navigationBarTitleDisplayMode(.large) //Prevents title from auto displaying in center
    }
}

