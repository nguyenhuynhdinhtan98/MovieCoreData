//
//  AddReviewViewModel.swift
//  MovieApp
//
//  Created by Mohammad Azam on 3/2/21.
//

import Foundation
import CoreData

class AddReviewViewModel: ObservableObject {
    
    var title: String = ""
    var content: String = ""
    
    
    func addReviewForMovie(movie: MovieViewModel) {
        let movie: Movie? = Movie.byID(id: movie.id)
        if let movie = movie {
            let review = Review(context: CoreDataManager.shared.viewContext)
            review.title = self.title
            review.content = self.content
            review.publishedAt = Date()
            review.movie = movie
            review.save()
        }
    }
}
