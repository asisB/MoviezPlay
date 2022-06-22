//
//  SearchViewModel.swift
//  MoviezPlay
//
//  Created by Ashish Basnet on 22/06/2022.
//

import SwiftUI
import Combine
import Foundation

class SearchViewModel: ObservableObject {
    @Published var query = ""
    @Published var movie: [Movie]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?
    
    private var subscriptionToken: AnyCancellable?
    
    let movieService: MovieService
    
    var isEmptyResult: Bool {
        self.query.isEmpty && self.movie != nil &&  self.movie!.isEmpty
    }
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func startObserve() {
        guard subscriptionToken == nil else { return }
        
        self.subscriptionToken = self.$query
            .map { [weak self] text in
                self?.movie = nil
                self?.error = nil
                return text
                
        }.throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] in self?.search(query: $0) }
    }
    
    func search(query: String) {
        self.movie = nil
        self.isLoading = false
        self.error = nil
        
        guard !query.isEmpty else {
            return
        }
        
        self.isLoading = true
        self.movieService.searchMovie(query: query) {[weak self] (result) in
            guard let self = self, self.query == query else { return }
            
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movie = response.results
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    deinit {
        self.subscriptionToken?.cancel()
        self.subscriptionToken = nil
    }
    
}
