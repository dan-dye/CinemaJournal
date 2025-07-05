//
//  MyReviewsView.swift
//  assignment4
//
//  Created by Daniel Dye on 7/4/25.
//

import SwiftUI
import FirebaseAuth

struct MyReviewsView: View {
    let user = Auth.auth().currentUser
    @State var isLoggedIn: Bool = true
    @StateObject var myReviews = ReviewViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(myReviews.reviews) { review in
                    NavigationLink {
                        ReviewDetail(review: review)
                    } label : {
                        Text(review.id!)
                    }
                    
                }
            }
            .onAppear {
                myReviews.fetchReviews()
            }
        }
    }
}

#Preview {
    MyReviewsView()
}
