//
//  TvSerieDetailView.swift
//  NC1
//
//  Created by Davide Ragosta on 21/11/22.
//

import SwiftUI

struct TvSerieDetailView: View {
    
    let tvserieId: Int
    @ObservedObject private var tvserieDetailState = TvSerieDetailState()
    
    var body: some View {
        ZStack {
            LoadingView(isLoading: self.tvserieDetailState.isLoading, error: self.tvserieDetailState.error) {
                self.tvserieDetailState.loadTvSerie(id: self.tvserieId)
            }
            
            if tvserieDetailState.tvserie != nil {
                TvSerieDetailListView(tvserie: self.tvserieDetailState.tvserie!)
                
            }
        }
        .navigationBarTitle(tvserieDetailState.tvserie?.name ?? "")
        .onAppear {
            self.tvserieDetailState.loadTvSerie(id: self.tvserieId)
        }
    }
}

struct TvSerieDetailListView: View {
    
    let tvserie: TVSerie
    @State private var selectedTrailer: TVVideo?
    let imageLoader = ImageLoader()
    
    var body: some View {
        List {
            
            TvSerieDetailImage(imageLoader: imageLoader, imageURL: self.tvserie.backdropURL)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            HStack {
                Text(tvserie.genreText)
                Text("·")
                Text("S: " + tvserie.durationText )
            }
            
            Text(tvserie.overview)
            
            HStack {
                if !tvserie.ratingText.isEmpty {
                    Text(tvserie.ratingText).foregroundColor(.yellow)
                }
                Text(tvserie.scoreText)
            }
            
            Divider()
            
            HStack(alignment: .top, spacing: 4) {
                if tvserie.cast != nil && tvserie.cast!.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Cast").font(.headline)
                        ForEach(self.tvserie.cast!.prefix(9)) { cast in
                            Text(cast.name)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    
                }
                
                if tvserie.crew != nil && tvserie.crew!.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        if tvserie.directors != nil && tvserie.directors!.count > 0 {
                            Text("Regista(i)").font(.headline)
                            ForEach(self.tvserie.directors!.prefix(2)) { crew in
                                Text(crew.name)
                            }
                        }
                        
                        if tvserie.producers != nil && tvserie.producers!.count > 0 {
                            Text("Prodttore(i)").font(.headline)
                                .padding(.top)
                            ForEach(self.tvserie.producers!.prefix(2)) { crew in
                                Text(crew.name)
                            }
                        }
                        
                        if tvserie.screenWriters != nil && tvserie.screenWriters!.count > 0 {
                            Text("Sceneggiatore(i)").font(.headline)
                                .padding(.top)
                            ForEach(self.tvserie.screenWriters!.prefix(2)) { crew in
                                Text(crew.name)
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
            }
            
            Divider()
            
            if tvserie.youtubeTrailers != nil && tvserie.youtubeTrailers!.count > 0 {
                Text("Trailers").font(.headline)
                
                ForEach(tvserie.youtubeTrailers!) { trailer in
                    Button(action: {
                        self.selectedTrailer = trailer
                    }) {
                        HStack {
                            Text(trailer.name)
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(Color(UIColor.systemBlue))
                        }
                    }
                }
            }
        }
        .sheet(item: self.$selectedTrailer) { trailer in
            SafariView(url: trailer.youtubeURL!)
        }
    }
}

struct TvSerieDetailImage: View {
    
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}

struct TvSerieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TvSerieDetailView(tvserieId: Movie.stubbedMovie.id)
        }
    }
}


