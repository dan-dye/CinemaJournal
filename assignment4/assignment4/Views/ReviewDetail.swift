//
//  ReviewDetail.swift
//  assignment4
//
//  Created by Daniel Dye on 7/4/25.
//

import SwiftUI

struct ReviewDetail: View {
    var review : ReviewModel
    @State var movie = MovieModel(id : 0, overview : "", poster_path : "", release_date : "", title : "")
    var body: some View {
        VStack {
            Text(review.content)
            Text(String(review.rating))
            Text(movie.title)
        }
        .onAppear {
            Task {
                movie = try! await MovieService.shared.findMovie(query: review.movie)
            }
        }
    }
}
