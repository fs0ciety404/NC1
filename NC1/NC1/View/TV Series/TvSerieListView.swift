//
//  TvSerieListView.swift
//  NC1
//
//  Created by Davide Ragosta on 21/11/22.
//

import SwiftUI

struct TvSerieListView: View {
    
    @ObservedObject private var nowPlayingState = TvSerieListState()
    @ObservedObject private var topRatedState = TvSerieListState()
    @ObservedObject private var popularState = TvSerieListState()
    
    var body: some View {
        NavigationView {
            List {
                Group {
                    if nowPlayingState.tvseries != nil {
                        TvSeriePosterCarouselView(title: "Now Playing", tvseries: nowPlayingState.tvseries!)
                        
                    } else {
                        LoadingView(isLoading: self.nowPlayingState.isLoading, error: self.nowPlayingState.error) {
                            self.nowPlayingState.loadTvSeries(with: .nowPlaying)
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))

                Group {
                    if topRatedState.tvseries != nil {
                        TvSerieBackdropCarouselView(title: "Top Rated", tvseries: topRatedState.tvseries!)
                        
                    } else {
                        LoadingView(isLoading: self.topRatedState.isLoading, error: self.topRatedState.error) {
                            self.topRatedState.loadTvSeries(with: .topRated)
                        }
                    }
                    
                    
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if popularState.tvseries != nil {
                        TvSerieBackdropCarouselView(title: "Popular", tvseries: popularState.tvseries!)
                        
                    } else {
                        LoadingView(isLoading: self.popularState.isLoading, error: self.popularState.error) {
                            self.popularState.loadTvSeries(with: .popular)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
                
                
                
            }
        }
        .onAppear {
            self.nowPlayingState.loadTvSeries(with: .nowPlaying)
            self.topRatedState.loadTvSeries(with: .topRated)
            self.popularState.loadTvSeries(with: .popular)
        }
        
    }
}

struct TvSerieListView_Previews: PreviewProvider {
    static var previews: some View {
        TvSerieListView()
    }
}
