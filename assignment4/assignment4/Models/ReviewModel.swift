//
//  ReviewModel.swift
//  assignment4
//
//  Created by Daniel Dye on 7/4/25.
//

import Foundation
import FirebaseFirestore

final class ReviewModel: Codable, Identifiable{
    @DocumentID var id: String?
    let content: String
    let rating: Int
    let user: String
    let movie: Int
}
