//
//  MoviePosterCard.swift
//  NC1
//
//  Created by Davide Ragosta on 21/11/22.
//

import SwiftUI

struct TvSeriePosterCard: View {
    
    let tvserie: TVSerie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        ZStack {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
                Text(tvserie.name)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(width: 204, height: 306)
        .onAppear {
            self.imageLoader.loadImage(with: self.tvserie.posterURL)
        }
    }
}

struct TvSeriePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        TvSeriePosterCard(tvserie: TVSerie.stubbedTVSerie)
    }
}
