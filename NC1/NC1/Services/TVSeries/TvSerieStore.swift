//
//  TvSerieStore.swift
//  NC1
//
//  Created by Davide Ragosta on 19/11/22.
//

import Foundation

class TvSerieStore: TVSerieService {
    
    static let shared = TvSerieStore()
    private init() {}
    
    private let apiKey = "61b225cc7e473d024b48d20995cbb36a"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchTVs(from endpoint: TVSerieListEndpoint, completion: @escaping (Result<TvSerieResponse, TVSerieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecodeTv(url: url, completion: completion)
    }
    
    func fetchTV(id: Int, completion: @escaping (Result<TVSerie, TVSerieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecodeTv(url: url, params: [
            "append_to_response": "videos,credits",
            "language": "it",
        ], completion: completion)
    }
    
    func searchTV(query: String, completion: @escaping (Result<TvSerieResponse, TVSerieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/search/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecodeTv(url: url, params: [
            "language": "it",
            "include_adult": "false",
            "region": "it",
            "query": query
        ], completion: completion)
    }
    
    private func loadURLAndDecodeTv<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, TVSerieError>) -> ()) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
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
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
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
    
    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, TVSerieError>, completion: @escaping (Result<D, TVSerieError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
    
    
}

