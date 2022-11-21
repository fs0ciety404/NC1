//
//  MovieBackdropCard.swift
//  NC1
//
//  Created by Davide Ragosta on 21/11/22.
//

import SwiftUI

struct TvSerieBackdropCard: View {
    
    let tvserie: TVSerie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                
                if self.imageLoader.image != nil {
                    Image(uiImage: self.imageLoader.image!)
                    .resizable()
                }
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 4)
            
            Text(tvserie.name)
        }
        .lineLimit(1)
        .onAppear {
            self.imageLoader.loadImage(with: self.tvserie.backdropURL)
        }
    }
}

struct TvSerieBackdropCard_Previews: PreviewProvider {
    static var previews: some View {
        TvSerieBackdropCard(tvserie: TVSerie.stubbedTVSerie)
    }
}
