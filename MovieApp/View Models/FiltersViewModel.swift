//
//  FiltersViewModel.swift
//  MovieApp
//
//  Created by tantest on 06/02/2023.
//

import Foundation

class FiltersViewModel: ObservableObject {
    func filtersMovieByReleaseDate(releaseDate: Date) -> [MovieViewModel] {
        return Movie.byReleaseDate(releaseDate: releaseDate).map(MovieViewModel.init)
    }
    
    func filterMovieByReleaseDateRange(lower: Date , upper: Date) -> [MovieViewModel] {
        return Movie.byReleaseDateRange(lower: lower, upper: upper).map(MovieViewModel.init)
    }
    
    func filterbByReleaseDateMinimumRating(lower: Date?, upper: Date?, minimumRating: Int?) -> [MovieViewModel] {
        return Movie.byReleaseDateMinimumRating(lower: lower, upper: upper, minimumRating: minimumRating).map(MovieViewModel.init)
    }
}
