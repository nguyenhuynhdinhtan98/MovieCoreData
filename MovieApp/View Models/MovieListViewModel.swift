//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Mohammad Azam on 2/26/21.
//

import Foundation
import CoreData

class MovieListViewModel: ObservableObject {
    
    @Published var movies = [MovieViewModel]()
    @Published var filterEnabled: Bool = false
    
    @Published var selectedSortOption: SortOptions = .title
    @Published var selectedSortDirection: SortDirection = .ascending
    
    
    func deleteMovie(movie: MovieViewModel) {
        let movie: Movie? = Movie.byID(id: movie.id)
        if let movie = movie {
//            CoreDataManager.shared.deleteMovie(movie)
            movie.delete()
        }
    }
    
    func getAllMovies() {
        let movies: [Movie] = Movie.getAll()
        DispatchQueue.main.async {
            self.movies = movies.map(MovieViewModel.init)
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
