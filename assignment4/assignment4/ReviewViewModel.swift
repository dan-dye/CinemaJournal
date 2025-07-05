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
    
    func fetchReviews() {
        self.reviews.removeAll() //Removes reviews from array to prevent duplication
        
        db.collection("reviews")
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
}
