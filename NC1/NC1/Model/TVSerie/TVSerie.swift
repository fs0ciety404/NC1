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
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    let releaseDate: String?
    
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
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
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
    
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return TVSerie.yearFormatter.string(from: date)
    }
    
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        return TVSerie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
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

