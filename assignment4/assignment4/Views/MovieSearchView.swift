//
//  MovieSearchView.swift
//  assignment4
//
//  Created by Daniel Dye on 7/5/25.
//

import SwiftUI

/*Movie Search
 Allows the user to search for a film using the title.
 Search results provided by TMDB API.
 */

struct MovieSearchView: View {
    @State var searchText: String = ""
    @State var movieResults: [MovieModel] = []
    @Binding var path: [Route]
    var body: some View {
        VStack {
            TextField("Search for a film...", text: $searchText) {
                
            }
            .padding()
            .background((Color.gray.opacity(0.2)))
            .cornerRadius(10)
            Spacer()
            //Movie Search Results
            List {
                ForEach(movieResults) { result in
                    let year = result.release_date?.prefix(4) ?? "Unknown" //Get year from date
                    let title = "\(result.title) (\(year))" //Attaches year to title for easier differentiation of duplicate titles.
                    Button(title) {
                        path.append(.movieDetails(result))
                    }
                }
            }
            Button("Search") {
                Task {
                    do {
                        //Fetches movie data matching the query.
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

