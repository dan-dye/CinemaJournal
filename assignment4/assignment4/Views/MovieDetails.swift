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
        ScrollView {
            VStack(alignment : .center, spacing: 10) {
                Button("New Review") {
                    path.append(.createReview(movie))
                }
                .padding()
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                Spacer()
                Section {
                    Text(movie.title)
                        .font(.system(.largeTitle))
                    
                        .padding(.horizontal)
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200/" + (movie.poster_path ?? "")))
                        .cornerRadius(10)
                        .padding()
                }
                Text("Release: " + movie.release_date)
                    .padding()
                    .font(.system(size: 14))
                    .padding(.horizontal)
                    .padding()
                Text(movie.overview)
                    .font(.system(size: 16))
                    .padding(.horizontal)
                    .background {
                        Color.white.opacity(1)
                            .ignoresSafeArea()
                    }
                
                .multilineTextAlignment(.center)
            }
            .padding()
        }
    }
}

