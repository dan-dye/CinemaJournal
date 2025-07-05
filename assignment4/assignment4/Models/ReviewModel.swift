//
//  ReviewModel.swift
//  assignment4
//
//  Created by Daniel Dye on 7/4/25.
//

import Foundation
import FirebaseFirestore

final class ReviewModel: Codable, Identifiable{
    init(){
        id = nil
        content = ""
        rating = 0
        user = ""
        movie = 0
    }
    @DocumentID var id: String?
    var content: String
    var rating: Int
    var user: String
    var movie: Int
    var movieTitle: String?
}
