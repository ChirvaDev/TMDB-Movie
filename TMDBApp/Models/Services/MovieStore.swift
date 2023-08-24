//
//  MovieStore.swift
//  TMDBApp
//
//  Created by Pro on 27.03.2023.
//

import Foundation

class MovieStore: MovieService {
    
    static let shared = MovieStore()
    private init() {}
    
    private let apiKey = "85a94401e18cb535d8b768fcbbd48a1e"
    private let baseAPIURL = "https://www.themoviedb.org/"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchMovies(from endpoint: MovieListEndpoints, complection: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchMovie(id: Int, complection: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: ["append to response": "videos, credits"], completion: completion)
    }
    
    func serchMovie(querty: String, complection: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: ["language" : "en-US"]?, completion: completion)
        
        
        private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>) ->()) {
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                completion(.failure(.invalidEndpoint))
                return
            }
            
            var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
            if let params = params {
                queryItems.append(contentsOf: params.map{URLQueryItem(name: $0.key, value: $0.value) })
            }
            
            urlComponents.queryItems = queryItems
            
            guard let finalURL = urlComponents.url else {
                completion(.failure(.invalidEndpoint))
                return
            }
            
            urlSession.dataTask(with: finalURL) { [weak self] (data, responce, error) in
                guard  let self = self else { return }
                if error != nil{
                    self.executeCompletionHandlerInMainThred(with: .failure(.apiError), completion: completion)
                    return
                }
                guard let httpResponse = responce as? HTTPURLResponse, 200..<300 = httpResponse.statusCode else{
                    self.executeCompletionHandlerInMainThred(with: .failure(.invalidResponse), completion: completion)
                    return
                }
                guard let data = data else {
                    self.executeCompletionHandlerInMainThred(with: .failure(.noData), completion: completion)
                    return
                }
                do {
                    let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                    self.executeCompletionHandlerInMainThred(with: .success(decodedResponse), completion: completion)
                } catch {
                    self.executeCompletionHandlerInMainThred(with: .failure(.serializationError), completion: completion)
                    
                }
                
            }.resume()
            
        }
        
         func executeCompletionHandlerInMainThred<D: Decodable>(with results: Result<D, MovieError>, completion: @escaping(Result<D, MovieError>) -> ()) {
            DispatchQueue.main.async {
                completion(results)
            }
        }
        
    }
}

