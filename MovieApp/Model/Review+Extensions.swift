//
//  Review+Extensions.swift
//  MovieApp
//
//  Created by Tân Nguyễn on 03/12/2022.
//

import Foundation
import CoreData
import SwiftUI

extension Review: BaseModel {
    static func byID<T>(id: NSManagedObjectID) -> T? where T : NSManagedObjectID {
        return nil
    }
    
    static func getReviewsByMovieId(movieId: NSManagedObjectID) -> [Review] {
        let request: NSFetchRequest<Review> = Review.fetchRequest()
        request.predicate = NSPredicate(format: "movie = %@", movieId)
        do {
            return try CoreDataManager.shared.viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
