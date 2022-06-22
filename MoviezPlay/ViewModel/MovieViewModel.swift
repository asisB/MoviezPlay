//
//  MovieListState.swift
//  MoviezPlay
//
//  Created by Ashish Basnet on 21/06/2022.
//

import Foundation
import SwiftUI

class MovieViewModel: ObservableObject {
    @Published var movie: [Movie]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?
    
    private let movieService: MovieService
    
    init(movieService: MovieService = MovieStore.shared){
        self.movieService = movieService
    }
    
    func loadMovie(with endpoint: MovieListEndPoint) {
        self.movie = nil
        self.isLoading = true
        
        self.movieService.fetchMovies(from: endpoint) { [weak self] (result)  in
            guard let self = self else {return}
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movie = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
        
        
    }
    
}
