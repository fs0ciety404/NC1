//
//  File.swift
//  NC1
//
//  Created by Davide Ragosta on 19/11/22.
//

import SwiftUI

class TvSerieDetailState: ObservableObject {
    
    private let tvSerieService: TVSerieService
    @Published var tvserie: TVSerie?
    @Published var isLoading = false
    @Published var error: NSError?
    
    init(tvSerieService: TVSerieService = TvSerieStore.shared) {
        self.tvSerieService = tvSerieService
    }
    
    func loadTvSerie(id: Int) {
        self.tvserie = nil
        self.isLoading = false
        self.tvSerieService.fetchTV(id: id) {[weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let tvserie):
                self.tvserie = tvserie
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
