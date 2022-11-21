//
//  TVSeries+Stub.swift
//  NC1
//
//  Created by Davide Ragosta on 19/11/22.


import Foundation


extension TVSerie {
    
    static var stubbedTVSeries: [TVSerie] {
        let response: TvSerieResponse? = try? Bundle.main.loadAndDecodeJSONTV(filename: "tvseries_list")
        return response!.results
    }
    
    static var stubbedTVSerie: TVSerie {
        stubbedTVSeries[0]
    }
    
}

extension Bundle {
    
    func loadAndDecodeJSONTV<D: Decodable>(filename: String!) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}

