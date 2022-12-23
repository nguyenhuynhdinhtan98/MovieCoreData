//
//  Actor+Extensions.swift
//  MovieApp
//
//  Created by Tân Nguyễn on 23/12/2022.
//

import Foundation
import CoreData

extension Actor: BaseModel {
    static func getActorByMovie(movieId: NSManagedObjectID) -> [Actor] {
        guard let movie = Movie.byID(id: movieId) as? Movie , let actors = movie.actors else { return [] }
        return actors.allObjects as? [Actor] ?? []
    }
}
