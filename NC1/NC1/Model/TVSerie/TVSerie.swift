//
//  TVSeries.swift
//  NC1
//
//  Created by Davide Ragosta on 19/11/22.
//

import Foundation

struct TvSerieResponse: Decodable {
    
    let results: [TVSerie]
}


struct TVSerie: Decodable, Identifiable, Hashable {
    static func == (lhs: TVSerie, rhs: TVSerie) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int
    let name: String
    let backdropPath: String?
    let posterPath: String?
    let firstAirDate: String
    let inProduction: Bool?
    let lastAirDate: String?
    let lastEpisodeToAir: LastEpisodeToAir?
    let numberOfSeasons: Int?
    let overview: String
    let seasons: [Season]?
    let voteAverage: Double
    let voteCount: Int
    let genres: [TVGenre]?
    let credits: TVCredit?
    let videos: TVVideoResponse?
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    var durationText: String {
        guard let runtime = self.numberOfSeasons, runtime > 0 else {
            return "n/a"
        }
        return TVSerie.durationFormatter.string(from: TimeInterval(runtime * 60)) ?? "n/a"
    }
    
    var genreText: String {
        genres?.first?.name ?? "n/a"
    }
    
    var ratingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(ratingText.count)/10"
    }
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var cast: [TVCast]? {
        credits?.cast
    }
    
    var crew: [TVCrew]? {
        credits?.crew
    }
    
    var directors: [TVCrew]? {
        crew?.filter { $0.job.lowercased() == "regista" }
    }
    
    var producers: [TVCrew]? {
        crew?.filter { $0.job.lowercased() == "produttore" }
    }
    
    var screenWriters: [TVCrew]? {
        crew?.filter { $0.job.lowercased() == "storia" }
    }
    
    var youtubeTrailers: [TVVideo]? {
        videos?.results.filter { $0.youtubeURL != nil }
    }
    
}

struct Season: Decodable {
    let airDate: String?
    let episodeCount, id: Int?
    let name, overview: String?
    let posterPath: String?
    let seasonNumber: Int?
}

struct LastEpisodeToAir: Decodable {
    let airDate: String?
    let episodeNumber, id: Int?
    let name, overview, productionCode: String?
    let runtime, seasonNumber, showID: Int?
    let stillPath: String?
    let voteAverage, voteCount: Int?
}

struct TVGenre: Decodable {
    
    let name: String
    
}

struct TVCredit: Decodable {
    
    let cast: [TVCast]
    let crew: [TVCrew]
}

struct TVCast: Decodable, Identifiable {
    let id: Int
    let character: String
    let name: String
}

struct TVCrew: Decodable, Identifiable {
    let id: Int
    let job: String
    let name: String
}

struct TVVideoResponse: Decodable {
    
    let results: [TVVideo]
}

struct TVVideo: Decodable, Identifiable {
    
    let id: String
    let key: String
    let name: String
    let site: String
    
    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}

