//
//  MovieViewModel.swift
//  assignment4
//
//  Created by Daniel Dye on 7/4/25.
//

import Foundation

class MovieViewModel : ObservableObject {
    @Published private(set) var moviesData = [MovieModel]()
    @Published var hasError: Bool = false
    @Published var error : MovieModelError?
    private let url = "https://api.themoviedb.org/3/movie/top_rated?page=1&total_pages=3&api_key=6201b3abc8dc539ff570547c50e0852d"
    
    
    @MainActor
    func fetchData() async {
        if let url = URL(string: url) {
            do {
                let (data, _) = try await URLSession
                    .shared
                    .data(from: url)
                guard let movieResults = try JSONDecoder().decode(MovieResults?.self, from: data) else {
                    self.hasError.toggle()
                    self.error = MovieModelError.decodeError
                    return
                }
                self.moviesData = movieResults.results
            } catch {
                self.hasError.toggle()
                self.error = MovieModelError.customError(error: error)
            }

        }
    }
}

extension MovieViewModel {
    enum MovieModelError : LocalizedError {
        case decodeError
        case customError(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .decodeError:
                return "Decode Error"
            case .customError(error: let error):
                return error.localizedDescription
            }
        }
    }
}
