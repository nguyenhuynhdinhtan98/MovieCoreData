//
//  ReviewListViewModel.swift
//  MovieApp
//
//  Created by Mohammad Azam on 3/2/21.
//

import Foundation
import CoreData

class ReviewListViewModel: ObservableObject {
  
   @Published var reviews = [ReviewViewModel]()
    
    func getReviewByIds(vm: MovieViewModel) {
//        let movie = CoreDataManager.shared.getMovieById(id: vm.id)
//        if let movie = movie {
//            DispatchQueue.main.async {
//                self.reviews = (movie.reviews?.allObjects as! [Review]).map(ReviewViewModel.init)
//            }
//        }
        DispatchQueue.main.async {
            self.reviews = Review.getReviewsByMovieId(movieId: vm.id).map(ReviewViewModel.init)
        }
    }
}

struct ReviewViewModel {
    
    let review: Review

    var reviewId: NSManagedObjectID {
        return review.objectID
    }
    
    var title: String {
        return review.title ?? ""
    }
    
    var content: String {
        return review.content ?? ""
    }
    
    var date: Date? {
        return review.publishedAt!
    }
    
}
