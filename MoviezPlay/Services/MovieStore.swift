//
//  MovieStore.swift
//  MoviezPlay
//
//  Created by Ashish Basnet on 18/06/2022.
//

import Foundation

class MovieStore: MovieService {
    
    static let shared = MovieStore()
    private init() {}
    
    private let API_KEY = "629792ea896532d34110b2d8d30685e1"
    private let BASE_URL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchMovies(from endpoint: MovieListEndPoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(BASE_URL)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(BASE_URL)/movie/\(id)") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        self.loadURLAndDecode(url: url, params: ["append_to_response" : "video,credits"], completion: completion)
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(BASE_URL)/search/movie") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
                                "language" : "en-US",
                                "include_adult" : "false",
                                "region" : "US",
                                "query" : query
                              ],
                              completion: completion)
    }
    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String:String]? = nil, completion: @escaping (Result<D, MovieError>) -> ()) {
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: API_KEY)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noDataresponse), completion: completion)
                return
            }
            
            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
            } catch {
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
}
