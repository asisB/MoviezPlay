//
//  MovieService.swift
//  MoviezPlay
//
//  Created by Ashish Basnet on 18/06/2022.
//

import Foundation

protocol MovieService {
    func fetchMovies(from endpoint: MovieListEndPoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
}

enum MovieListEndPoint: String {
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    
    var description: String {
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .upcoming:
            return "Upcoming"
        case .popular:
            return "popular"
        case .topRated:
            return "Top Rated"
        }
    }
}

enum MovieError: Error, CustomNSError {
    case apiError
    case invalidEndPoint
    case invalidResponse
    case noDataresponse
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError:
            return "Failed to fetch data"
        case .invalidEndPoint:
            return "invalid endpoint"
        case .invalidResponse:
            return "Invalid response"
        case .noDataresponse:
            return "No data"
        case .serializationError:
            return "Failed to decode data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
    
}
