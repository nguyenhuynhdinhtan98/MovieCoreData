//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Mohammad Azam on 2/26/21.
//

import Foundation
import CoreData

class MovieListViewModel: NSObject ,ObservableObject {
    
    @Published var movies = [MovieViewModel]()
    @Published var filterEnabled: Bool = false
    @Published var sortEnabled: Bool = false 
    @Published var selectedSortOption: SortOptions = .title
    @Published var selectedSortDirection: SortDirection = .ascending
    
    private var fetchedResultsController: NSFetchedResultsController<Movie>!
    
    func deleteMovie(movie: MovieViewModel) {
        let movie: Movie? = Movie.byID(id: movie.id)
        if let movie = movie {
//            CoreDataManager.shared.deleteMovie(movie)
            movie.delete()
        }
    }
    
    func getAllMovies() {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
//        let movies: [Movie] = Movie.getAll()
        DispatchQueue.main.async {
            self.movies =  (self.fetchedResultsController.fetchedObjects ?? []).map(MovieViewModel.init)
        }
    }
    
    func sort() {
        let request: NSFetchRequest<Movie>  = Movie.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: selectedSortOption.rawValue, ascending: selectedSortDirection.value)]
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true),  NSSortDescriptor(key: "rating", ascending: false)]
        let fetchResultsController : NSFetchedResultsController<Movie> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        try? fetchResultsController.performFetch()
        
        DispatchQueue.main.async {
            self.movies = (fetchResultsController.fetchedObjects ?? []).map(MovieViewModel.init)
        }
    }
}

extension MovieListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async {
            self.movies = (controller.fetchedObjects as? [Movie] ?? []).map(MovieViewModel.init)
        }
    }
}

struct MovieViewModel {
    
    let movie: Movie
    
    var id: NSManagedObjectID {
        return movie.objectID
    }
    
    var title: String {
        return movie.title ?? ""
    }
    
    var director: String {
        return movie.director ?? "Not available"
    }
    
    var releaseDate: String? {
        return movie.releaseDate?.asFormattedString()
    }
    
    var rating: Int? {
        return Int(movie.rating)
    }
}


enum SortDirection: CaseIterable {
    
    case ascending
    case descending
    
    var value: Bool {
        switch self {
            case .ascending:
                return true
            case .descending:
                return false
        }
    }
    
    var displayText: String {
        switch self {
            case .ascending:
                return "Ascending"
            case .descending:
                return "Descending"
        }
    }
}

enum SortOptions: String, CaseIterable {
    
    case title
    case releaseDate
    case rating
    
    var displayText: String {
        switch self {
            case .title:
                return "Title"
            case .releaseDate:
                return "Release Date"
            case .rating:
                return "Rating"
        }
    }
}
