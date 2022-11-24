//
//  TabView.swift
//  NC1
//
//  Created by Davide Ragosta on 23/11/22.
//

import SwiftUI

struct Tab_View: View {
    var body: some View {
        
        TabView {
            MovieListView()
                .tabItem {
                    VStack {
                        Image(systemName: "tv")
                        Text("Movies")
                    }
                }
                .tag(0)
            /*
            TvSerieListView()
                .tabItem {
                    VStack {
                        Image(systemName: "tv")
                        Text("Tv Series")
                    }
                }
                .tag(1)
            */
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

struct Tab_View_Previews: PreviewProvider {
    static var previews: some View {
        Tab_View()
    }
}
