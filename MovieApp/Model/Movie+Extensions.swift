//
//  Movie+Extensions.swift
//  MovieApp
//
//  Created by Tân Nguyễn on 09/12/2022.
//

import Foundation
import CoreData

extension Movie: BaseModel {
    static func byActorTitleByMovie (title: String) -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "%K.%K CONTAINS %@",#keyPath(Movie.actors),#keyPath(Actor.name) ,title)
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    static func byMovieTitle(title: String) -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "%K BEGINSWITH[cd] %@",#keyPath(Movie.title) ,title)
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    static func byReleaseDateMinimumRating(lower: Date?, upper: Date?, minimumRating: Int?) -> [Movie] {
        var nsPredicate : [NSPredicate] = []
        if let lower = lower , let upper = upper {
            let dateRangePredicate = NSPredicate(format: "%K >= %@ AND %K <= %@",#keyPath(Movie.releaseDate) , lower as NSDate,#keyPath(Movie.releaseDate) , upper as NSDate)
            nsPredicate.append(dateRangePredicate)
        } else if let minimum = minimumRating {
            let minimumRatingPredicate =  NSPredicate(format: "%K >= %i ",#keyPath(Movie.rating) , minimum)
            nsPredicate.append(minimumRatingPredicate)
        }
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: nsPredicate)
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    static func byReleaseDateRange(lower: Date , upper: Date) -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "%K >= %@ AND %K <= %@",#keyPath(Movie.releaseDate) , lower as NSDate,#keyPath(Movie.releaseDate) , upper as NSDate)
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    static func byReleaseDate(releaseDate: Date) ->  [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "%K >= %@",#keyPath(Movie.releaseDate) , releaseDate as NSDate)
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    static func byActorName(name: String) -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "actors.name CONTAINS %@", name)
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error)
            return []
        }
        
    }
}
