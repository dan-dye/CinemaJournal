//
//  MovieModel.swift
//  assignment4
//
//  Created by Daniel Dye on 7/4/25.
//

import Foundation

struct MovieModel : Codable, Identifiable {
    let id : Int
    let overview : String
    let poster_path : String
    let release_date : String
    let title : String
}

struct MovieResponseModel : Codable {
    let results : [MovieModel]
}
