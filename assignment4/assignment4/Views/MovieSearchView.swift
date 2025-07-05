//
//  MovieSearchView.swift
//  assignment4
//
//  Created by Daniel Dye on 7/5/25.
//

import SwiftUI

struct MovieSearchView: View {
    @State var searchText: String = ""
    @State var movieResults: [MovieModel] = []
    var body: some View {
        VStack {
            TextField("Search for a film...", text: $searchText) {
                
            }
            .padding()
            .background((Color.gray.opacity(0.2)))
            .cornerRadius(10)
            Spacer()
            List {
                ForEach(movieResults) { result in
                    NavigationLink {
                        MovieDetails(movie: result)
                    } label : {
                        Text(result.title)
                    }
                    
                }
            }
            Button("Search") {
                Task {
                    do {
                        let results = try await MovieService().searchMovies(query: searchText)
                        movieResults = results
                    } catch {
                        print("Error searching movies: \(error)")
                    }
                }
            }
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
        }
        .padding()

        
    }
    
}

#Preview {
    MovieSearchView()
}
