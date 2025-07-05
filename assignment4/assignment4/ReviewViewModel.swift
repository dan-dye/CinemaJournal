//
//  ReviewViewModel.swift
//  assignment4
//
//  Created by Daniel Dye on 7/4/25.
//

import Foundation
import FirebaseFirestore



class ReviewViewModel: ObservableObject {
    @Published private(set) var reviews = [ReviewModel]()
    let db = Firestore.firestore()
    
    func fetchReviews(user: String) {
        self.reviews.removeAll() //Removes reviews from array to prevent duplication
        
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
