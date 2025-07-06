//
//  ReviewDetail.swift
//  assignment4
//
//  Created by Daniel Dye on 7/4/25.
//

import SwiftUI

struct ReviewDetail: View {
    var review : ReviewModel
    @State var movie = MovieModel()
    @State private var showDeleteAlert = false
    @State private var reviewVM = ReviewViewModel()
    @Binding var path: [Route]
    var body: some View {
        ScrollView {
            VStack(alignment : .center, spacing: 10) {
                Spacer()
                HStack {
                    Button("Edit") {
                        path.append(.edit(review, movie))
                    }
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    Button("Delete") {
                        showDeleteAlert = true
                    }
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                }
                .padding()
                
                
                Section(header: Text(movie.title)
                    .font(.system(.headline))
                    .multilineTextAlignment(.center)) {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200/" + (movie.poster_path ?? "")))
                        .cornerRadius(10)
                        .padding()
                }
                    .padding()
                Section(header: Text("Review").font(.system(.subheadline))) {
                    Text("Rating: " + String(review.rating) + "/5")
                    Text(review.content)
                }
                .padding()
                Section(header: Text("Information").font(.system(.subheadline))) {
                    Text("Release: " + movie.release_date)
                        .padding()
                        .font(.system(size: 14))
                        .padding(.horizontal)
                        .padding()
                    Text(movie.overview)
                        .font(.system(size: 16))
                        .padding(.horizontal)
                        .background {
                            Color.white.opacity(1)
                                .ignoresSafeArea()
                        }
                    
                    .multilineTextAlignment(.center)
                }
            }
            .onAppear {
                Task {
                    movie = try! await MovieService.shared.findMovie(query: review.movie)
                }
            }
            .alert("Are you sure you want to delete?", isPresented: $showDeleteAlert) {
                        Button("Delete", role: .destructive) {
                            Task {
                                await reviewVM.deleteReview(review: review)
                                path = [.myReviews]
                            }
                        }
                        Button("Cancel", role: .cancel) { }
                    } message: {
                        Text("Deleted reviews cannot be recovered.")
                    }
        }
    }
}


