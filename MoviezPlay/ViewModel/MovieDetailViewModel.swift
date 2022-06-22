//
//  MovieDetailViewModel.swift
//  MoviezPlay
//
//  Created by Ashish Basnet on 22/06/2022.
//

import SwiftUI

class MovieDetailViewModel: ObservableObject {
    private var movieService: MovieService
    
    @Published  var movie: Movie?
    @Published var isLoading: Bool = false
    @Published var error: NSError?
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func loadMovie(id: Int) {
        self.movie = nil
        self.isLoading = false
        self.movieService.fetchMovie(id: id) { [weak self] (result) in
            guard let self = self else {return}
            
            self.isLoading = false
            switch result {
            case .success(let movie):
                self.movie = movie
                
            case .failure(let error):
                self.error = error as NSError
            }
            
        }
    }
    
    
}
