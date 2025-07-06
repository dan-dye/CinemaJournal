//
//  MovieDetails.swift
//  assignment4
//
//  Created by Daniel Dye on 7/5/25.
//

import SwiftUI

struct MovieDetails: View {
    var movie: MovieModel
    @Binding var path: [Route]
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
            
            Section(header: Text("Information")) {
                Text("Release: " + (movie.release_date ?? "Unknown"))
                Text(movie.overview)
            }
            
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
        .navigationBarTitleDisplayMode(.large)
    }
}

