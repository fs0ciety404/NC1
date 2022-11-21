//
//  TVSerieService.swift
//  NC1
//
//  Created by Davide Ragosta on 19/11/22.
//

import Foundation

import Foundation

protocol TVSerieService {
    
    func fetchTVs(from endpoint: TVSerieListEndpoint, completion: @escaping (Result<TvSerieResponse, TVSerieError>) -> ())
    func fetchTV(id: Int, completion: @escaping (Result<TVSerie, TVSerieError>) -> ())
    func searchTV(query: String, completion: @escaping (Result<TvSerieResponse, TVSerieError>) -> ())
}

enum TVSerieListEndpoint: String, CaseIterable, Identifiable {
    
    var id: String { rawValue }
    case nowPlaying = "airing_today"
    case latest = "latest"
    case topRated = "top_rated"
    case popular = "popular"
    
    var description: String {
        switch self {
            case .nowPlaying: return "Now Playing"
            case .latest: return "Latest"
            case .topRated: return "Top Rated"
            case .popular: return "Popular"
        }
    }
}

enum TVSerieError: Error, CustomNSError {
    
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
    
}
