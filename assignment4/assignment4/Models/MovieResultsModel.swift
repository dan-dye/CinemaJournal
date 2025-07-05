//
//  MovieResultsModel.swift
//  assignment4
//
//  Created by Daniel Dye on 7/4/25.
//

import Foundation

struct MovieResults : Codable {
    let page : Int
    let results : [MovieModel]
    let total_pages : Int
    let total_results : Int
}
