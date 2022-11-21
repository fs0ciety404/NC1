//
//  NC1App.swift
//  NC1
//
//  Created by Davide Ragosta on 14/11/22.
//

import SwiftUI

@main
struct NC1App: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                MovieListView()
                    .tabItem {
                        VStack {
                            Image(systemName: "tv")
                            Text("Movies")
                        }
                    }
                    .tag(0)
                
                TvSerieListView()
                    .tabItem {
                        VStack {
                            Image(systemName: "tv")
                            Text("Tv Series")
                        }
                    }
                    .tag(1)
                
                MovieSearchView()
                    .tabItem {
                        VStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    }
                    .tag(2)
                
            }
            
        }
    }
}
