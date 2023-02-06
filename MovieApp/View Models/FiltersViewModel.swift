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
}
