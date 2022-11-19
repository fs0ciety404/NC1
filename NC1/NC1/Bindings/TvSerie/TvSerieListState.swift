//
//  Filep.swift
//  NC1
//
//  Created by Davide Ragosta on 19/11/22.
//

import SwiftUI

class TvSerieListState: ObservableObject {
    
    @Published var tvserie: [TVSerie]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?

    private let tvSerieService: TVSerieService
    
    init(tvSerieService: TVSerieService = TvSerieStore.shared) {
        self.tvSerieService = tvSerieService
    }
    
    func loadTvSeries(with endpoint: TVSerieListEndpoint) {
        self.tvserie = nil
        self.isLoading = true
        self.tvSerieService.fetchTVs(from: endpoint) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.tvserie = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
}
