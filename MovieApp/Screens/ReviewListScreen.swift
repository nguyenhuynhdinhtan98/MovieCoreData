//
//  ReviewListScreen.swift
//  MovieApp
//
//  Created by Mohammad Azam on 3/2/21.
//

import SwiftUI

struct ReviewListScreen: View {
    
    let movie: MovieViewModel
    
    @State private var isPresented: Bool = false
    @StateObject private var reviewListVM = ReviewListViewModel()
    @State private var filterApplied: Bool = false
    
    var body: some View {
        VStack {
            List(reviewListVM.reviews, id: \.reviewId) { review in
                HStack {
                    VStack(alignment: .leading) {
                        Text(review.title)
                        Text(review.content)
                    }
                    Spacer()
                    Text(review.date?.asFormattedString() ?? "")
                }
            }
        }
        .navigationTitle("Movie Title")
        .navigationBarItems(trailing: Button("Add New Review") {
             isPresented = true
        })
        .sheet(isPresented: $isPresented, onDismiss: {
            if !filterApplied {
                reviewListVM.getReviewByIds(vm: movie)
            }
        }, content: {
            AddReviewScreen(movie: movie)
        })
        .onAppear(perform: {
            reviewListVM.getReviewByIds(vm: movie)
        })
    }
}

struct ReviewListScreen_Previews: PreviewProvider {
    static var previews: some View {
        let movie = MovieViewModel(movie: Movie(context: Movie.viewContext))
        ReviewListScreen(movie: movie).embedInNavigationView()
    }
}
