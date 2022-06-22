//
//  MovieDetailsView.swift
//  MoviezPlay
//
//  Created by Ashish Basnet on 22/06/2022.
//

import SwiftUI

struct MovieDetailsView: View {
    let movieID: Int
    @ObservedObject private var moviedetailViewModel = MovieDetailViewModel()
    
    var body: some View {
        ZStack {
            LoadingView(isLoading: self.moviedetailViewModel.isLoading, error: self.moviedetailViewModel.error) {
                self.moviedetailViewModel.loadMovie(id: self.movieID)
            }
            
            if moviedetailViewModel.movie != nil {
                MovieDetailListView(movie: self.moviedetailViewModel.movie!)
            }
        }
        .navigationTitle(moviedetailViewModel.movie?.title ?? "")
        .onAppear {
            self.moviedetailViewModel.loadMovie(id: self.movieID)
        }
        
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movieID: Movie.stubbedMovie.id)
    }
}
