//
//  MovieResultsModel.swift
//  assignment4
//
//  Created by Daniel Dye on 7/4/25.
//

import Foundation

//Model for the results of a movie search based on title.

struct MovieResults : Codable {
    let page : Int
    let results : [MovieModel]
    let total_pages : Int
    let total_results : Int
}
