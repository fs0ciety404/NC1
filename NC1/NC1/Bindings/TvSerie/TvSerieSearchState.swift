//
//  n.swift
//  NC1
//
//  Created by Davide Ragosta on 19/11/22.
//

import SwiftUI
import Combine
import Foundation

class TvSerieSearchState: ObservableObject {
    
    @Published var query = ""
    @Published var tvserie: [TVSerie]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private var subscriptionToken: AnyCancellable?
    
    let tvSerieService: TVSerieService
    
    var isEmptyResults: Bool {
        !self.query.isEmpty && self.tvserie != nil && self.tvserie!.isEmpty
    }
    
    init(tvSerieService: TVSerieService = TvSerieStore.shared) {
        self.tvSerieService = tvSerieService
    }
    
    func startObserve() {
        guard subscriptionToken == nil else { return }
        
        self.subscriptionToken = self.$query
            .map { [weak self] text in
                self?.tvserie = nil
                self?.error = nil
                return text
                
        }.throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] in self?.search(query: $0) }
    }
    
    func search(query: String) {
        self.tvserie = nil
        self.isLoading = false
        self.error = nil
        
        guard !query.isEmpty else {
            return
        }
        
        self.isLoading = true
        self.tvSerieService.searchTV(query: query) {[weak self] (result) in
            guard let self = self, self.query == query else { return }
            
            self.isLoading = false
            switch result {
            case .success(let response):
                self.tvserie = response.results
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    deinit {
        self.subscriptionToken?.cancel()
        self.subscriptionToken = nil
    }
}

