//
//  MovieService.swift
//  assignment4
//
//  Created by Daniel Dye on 7/4/25.
//

import Foundation


class MovieService {
    static let shared = MovieService()
    private let apiKey = "6201b3abc8dc539ff570547c50e0852d"
    private let baseURL = "https://api.themoviedb.org/3"

    func searchMovies(query: String) async throws -> [MovieModel] {
        guard let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return []
        }

        let urlString = "\(baseURL)/search/movie?api_key=\(apiKey)&query=\(queryEncoded)"
        guard let url = URL(string: urlString) else { return [] }

        let (data, _) = try await URLSession
            .shared
            .data(from: url)
        do {
            let movieResponse = try JSONDecoder().decode(MovieResults.self, from: data)
            return movieResponse.results
        } catch {
            print("Decoding error: \(error)")
                print(String(data: data, encoding: .utf8) ?? "No response body")
                return []
        }

    }
    
    func findMovie(query: Int) async throws -> MovieModel {
        let urlString = "\(baseURL)/movie/\(query)?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        
        let (data, _) = try await URLSession
            .shared
            .data(from: url)
        let foundMovie = try JSONDecoder().decode(MovieModel.self, from: data)
        return foundMovie
    }
}
