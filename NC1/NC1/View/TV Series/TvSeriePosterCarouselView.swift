//
//  TvSeriePosterCarouselView.swift
//  NC1
//
//  Created by Davide Ragosta on 21/11/22.
//

import SwiftUI

struct TvSeriePosterCarouselView: View {
    
    let title: String
    let tvseries: [TVSerie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.tvseries) { tvserie in
                        NavigationLink(destination: TvSerieDetailView(tvserieId: tvserie.id)) {
                            TvSeriePosterCard(tvserie: tvserie)
                        }.buttonStyle(PlainButtonStyle())
                            .padding(.leading, tvserie.id == self.tvseries.first!.id ? 16 : 0)
                            .padding(.trailing, tvserie.id == self.tvseries.last!.id ? 16 : 0)
                    }
                }
            }
        }
        
    }
}

struct TvSeriePosterCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        TvSeriePosterCarouselView(title: "Now Playing", tvseries: TVSerie.stubbedTVSeries)
    }
}
