//
//  ShowFiltersScreen.swift
//  MovieApp
//
//  Created by Mohammad Azam on 3/17/21.
//

import SwiftUI

struct ShowFiltersScreen: View {
    
    @State private var releaseDate: String = ""
    @State private var startDate: String = ""
    @State private var endDate: String = ""
    @State private var minimumRating: String = ""
    @State private var movieTitle: String = ""
    @State private var actorName: String = ""
    @State private var minimumReviewCount: String = ""
    
    @Binding var movies: [MovieViewModel]
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var filtersVM: FiltersViewModel = FiltersViewModel()
    
    var body: some View {
        Form {
            
            Section(header: Text("Search by release date")) {
                TextField("Enter release date", text: $releaseDate)
                HStack {
                    Spacer()
                    Button("Search") {
                        if let date = releaseDate.asDate() {
                           movies =  filtersVM.filtersMovieByReleaseDate(releaseDate: date)
                        }
                        presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by date range")) {
                TextField("Enter start date", text: $startDate)
                TextField("Enter end date", text: $endDate)
                HStack {
                    Spacer()
                    Button("Search") {
                        if let lower = startDate.asDate() , let upper = endDate.asDate() {
                            movies = filtersVM.filterMovieByReleaseDateRange(lower: lower, upper: upper)
                        }
                        presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by date range or rating")) {
                TextField("Enter start date", text: $startDate)
                TextField("Enter end date", text: $endDate)
                TextField("Enter minimum rating", text: $minimumRating)
                HStack {
                    Spacer()
                    Button("Search") {
                        let lowerBound = startDate.asDate()
                        let upperBound = endDate.asDate()
                        let minimum = Int(minimumRating)
                        movies = filtersVM.filterbByReleaseDateMinimumRating(lower: lowerBound, upper: upperBound, minimumRating: minimum)
                        presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by movie title begins with")) {
                TextField("Enter movie title", text: $movieTitle)
                HStack {
                    Spacer()
                    Button("Search") {
                        movies = filtersVM.filterMovieTitle(title: movieTitle)
                        presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by actor name")) {
                TextField("Enter actor name", text: $actorName)
                HStack {
                    Spacer()
                    Button("Search") {
                        movies = filtersVM.filterActorTitleByMovie(title: actorName)
                        presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            Section(header: Text("Search movies by minimum review count")) {
                   TextField("Enter minimum review count", text: $minimumReviewCount)
                   HStack {
                       Spacer()
                       Button("Search") {
                           
                           if !minimumReviewCount.isEmpty {
                               movies =  filtersVM.filterMoviesByMinimumReviewCount(rating: Int(minimumReviewCount) ?? 0)
                           }
                           
                           presentationMode.wrappedValue.dismiss()
                           
                       }.buttonStyle(PlainButtonStyle())
                       Spacer()
                   }
               }
            
        }
        .navigationTitle("Filters")
        .embedInNavigationView()
    }
}

//struct ShowFiltersScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowFiltersScreen(movies: [])
//    }
//}
