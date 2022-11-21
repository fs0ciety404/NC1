//
//  TvSerieBackdropCarouselView.swift
//  NC1
//
//  Created by Davide Ragosta on 21/11/22.
//

import SwiftUI

struct TvSerieBackdropCarouselView: View {
    
    let title: String
    let tvseries: [TVSerie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.tvseries) { tvserie in
                        NavigationLink(destination: TvSerieDetailView(tvserieId: tvserie.id)) {
                            TvSerieBackdropCard(tvserie: tvserie)
                                .frame(width: 272, height: 200)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, tvserie.id == self.tvseries.first!.id ? 16 : 0)
                        .padding(.trailing, tvserie.id == self.tvseries.last!.id ? 16 : 0)
                    }
                }
            }
        }
    }
}

struct TvSerieBackdropCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        TvSerieBackdropCarouselView(title: "Latest", tvseries: TVSerie.stubbedTVSeries)
    }
}
