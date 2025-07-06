//
//  MovieModel.swift
//  assignment4
//
//  Created by Daniel Dye on 7/4/25.
//

import Foundation

//Model for movies fetched from TMDB API

struct MovieModel : Codable, Identifiable, Hashable {
    init() {
        id = 0
        overview = ""
        poster_path = nil
        release_date = ""
        title = ""
    }
    let id : Int
    let overview : String
    let poster_path : String?
    let release_date : String?
    let title : String
}

