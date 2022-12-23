//
//  ActorListViewModel.swift
//  MovieApp
//
//  Created by Tân Nguyễn on 23/12/2022.
//

import Foundation
import CoreData

class ActorListViewModel: ObservableObject {
    
    @Published var actors: [ActorViewModel] = []
    
    func getListActor(vm: MovieViewModel) {
        DispatchQueue.main.async {
            self.actors = Actor.getActorByMovie(movieId: vm.id).map(ActorViewModel.init)
        }
    }
}


struct ActorViewModel {
    let actor: Actor
    var id: NSManagedObjectID {
        return actor.objectID
    }
    
    var name: String {
        return actor.name ?? ""
    }
    
    var movies: [MovieViewModel] {
        return Movie.byActorName(name: name).map(MovieViewModel.init)
    }
}
