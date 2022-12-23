//
//  AddActorViewModel.swift
//  MovieApp
//
//  Created by Tân Nguyễn on 22/12/2022.
//

import Foundation
import CoreData

class AddActorViewModel: ObservableObject {
    var name: String = ""
    
    func addActorByMovie(movieID: NSManagedObjectID){
        let movie: Movie? = Movie.byID(id: movieID)
        if let movie = movie {
            let actor = Actor(context: Actor.viewContext)
            actor.name = name
            actor.addToMovies(movie)
            actor.save()
        }
    }
}
