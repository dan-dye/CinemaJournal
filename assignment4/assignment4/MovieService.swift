//
//  MovieService.swift
//  assignment4
//
//  Created by Daniel Dye on 7/4/25.
//

import Foundation

/*Services for fetching movie data from TMDB database.*/

class MovieService {
    //Singleton static object
    static let shared = MovieService()
    //API key for TMDB
    private let apiKey = "6201b3abc8dc539ff570547c50e0852d"
    //Common beginning URL for TMDB API calls.
    private let baseURL = "https://api.themoviedb.org/3"

    //Runs a search on TMDB with the supplied query and returns matching films as a MovieResults object.
    func searchMovies(query: String) async throws -> [MovieModel] {
        //Formats query for url
        guard let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            //Return empty array if unable to format
            return []
        }

        //URL builder
        let urlString = "\(baseURL)/search/movie?api_key=\(apiKey)&query=\(queryEncoded)"
        guard let url = URL(string: urlString)
        else {
            //Returns empty array if fails
            return [] }

        //Fetch and decode JSON and return in MovieResults
        let (data, _) = try await URLSession
            .shared
            .data(from: url)
        do {
            let movieResponse = try JSONDecoder().decode(MovieResults.self, from: data)
            return movieResponse.results
        } catch {
            //Handle errors and return an empty array
            print("Decoding error: \(error)")
                print(String(data: data, encoding: .utf8) ?? "No response body")
                return []
        }

    }
    
    //Finds a single movie with the matching INT id.
    func findMovie(query: Int) async throws -> MovieModel {
        //URL builder
        let urlString = "\(baseURL)/movie/\(query)?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            //Returns error if fails
            fatalError("Invalid URL: \(urlString)")
        }
        
        //Fetch movie from API and decodes the JSON
        let (data, _) = try await URLSession
            .shared
            .data(from: url)
        let foundMovie = try JSONDecoder().decode(MovieModel.self, from: data)
        return foundMovie
    }
}
