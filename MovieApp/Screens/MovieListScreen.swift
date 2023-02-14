//
//  MovieListScreen.swift
//  MovieApp
//
//  Created by Mohammad Azam on 2/24/21.
//

import SwiftUI


enum Sheets: Identifiable {
    
    var id: UUID {
        return UUID()
    }
    
    case addMovie
    case showFilters
}

struct MovieListScreen: View {
    
    @StateObject private var movieListVM = MovieListViewModel()
    @State private var isPresented: Bool = false
    @State private var activeSheet: Sheets?
    @State private var filterApplied: Bool = false
    
     
    private func deleteMovie(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let movie = movieListVM.movies[index]
            // delete the movie
            movieListVM.deleteMovie(movie: movie)
            // get all movies
            movieListVM.getAllMovies()
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button("Reset") {
                        movieListVM.getAllMovies()
                    }
                    Spacer()
                    Button("Filter") {
                        filterApplied = true
                        activeSheet = .showFilters
                    }
                }.padding()
                List {
                    ForEach(movieListVM.movies, id: \.id) { movie in
                        NavigationLink(
                            destination: MovieDetailScreen(movie: movie),
                            label: {
                                MovieCell(movie: movie)
                            })
                    }.onDelete(perform: deleteMovie)
                }
                .navigationBarItems(trailing: Button("Add Movie") {
                    activeSheet = .addMovie
                })
                .sheet(item: $activeSheet, onDismiss: {
                    if !filterApplied {
                        movieListVM.getAllMovies()
                    }
                }, content: { item in
                    switch item {
                    case .addMovie:
                        AddMovieScreen()
                    case .showFilters:
                        ShowFiltersScreen(movies: $movieListVM.movies)
                    }
                })
                .onAppear(perform: {
                    UITableView.appearance().showsVerticalScrollIndicator = false
                    movieListVM.getAllMovies()
                })
            }.navigationBarHidden(true)
        }
    }
}

struct MovieListScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieListScreen()
        }
    }
}

struct MovieCell: View {
    
    let movie: MovieViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(movie.title)
                    .fontWeight(.bold)
                Text(movie.director)
                    .font(.caption2)
                Text(movie.releaseDate ?? "")
                    .font(.caption)
            }
            Spacer()
            RatingView(rating: .constant(movie.rating))
        }
    }
}
