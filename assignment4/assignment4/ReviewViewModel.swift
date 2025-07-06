//
//  ReviewViewModel.swift
//  assignment4
//
//  Created by Daniel Dye on 7/4/25.
//

import Foundation
import FirebaseFirestore

/*ReviewViewModel
    Handles CRUD with Firebase for reviews.
 */

class ReviewViewModel: ObservableObject {
    @Published private(set) var reviews = [ReviewModel]()
    let db = Firestore.firestore()
    
    //Fetch reviews from Firebase
    func fetchReviews(user: String) {
        self.reviews.removeAll() //Removes reviews from array to prevent duplication
        
        //Selects only reviews for the passed user.
        db.collection("reviews").whereField("user", isEqualTo: user)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            self.reviews.append(try document.data(as: ReviewModel.self))
                        } catch {
                            print(error)
                        }
                    }
                }
            }
    }
    
    //Saves a new review to Firebase
    func saveReview(review: ReviewModel) async {
        do {
            try await db.collection("reviews").document().setData([
                "content": review.content,
                "rating": review.rating,
                "user": review.user,
                "movie": review.movie,
                "movieTitle": review.movieTitle ?? "Unknown Title"
            ])
            print("Document successfully written!")
        } catch {
            print("Error writing document: \(error)")
        }
        
    }
    
    //Edits an existing review with Firebase
    func editReview(review: ReviewModel) async {
        let docRef = db.collection("reviews").document(review.id!)
        
        do {
            try await docRef.setData([
                "content": review.content,
                "rating": review.rating,
                "user": review.user,
                "movie": review.movie,
                "movieTitle": review.movieTitle ?? "Unknown Title"
            ])
            print("Document successfully updated!")
        } catch {
            print("Error updating document: \(error)")
        }
    }
    
    //Deletes a review from Firebase
    func deleteReview(review: ReviewModel) async {
        do {
            if let id = review.id {
                let docRef = db.collection("reviews").document(id)
                try await docRef.delete()
                print("Document successfully deleted!")
            }
        } catch {
            print("Error deleting document: \(error)")
        }
    }
    
}
