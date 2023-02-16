//
//  MovieDetailsView.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 16/02/2023.
//

import SwiftUI

struct MovieDetailsView: View {
    let movieDetail: MovieDetails
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                Image(systemName: movieDetail.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 150)
                ZStack(alignment: .leading) {
                    Color.cyan.opacity(0.8)
                    Text(movieDetail.name)
                        .padding(.leading, 16)
                }.frame(maxWidth: .infinity, maxHeight: 50)
            }.frame(maxWidth: .infinity, maxHeight: 150)
            .padding(.bottom, 16)
            
            VStack {
                Text(movieDetail.description)
            }.padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top) {
                    ForEach(movieDetail.cast, id: \.self) { cast in
                        Text(cast)
                            .frame(width: 70, height: 70)
                            .background(Color.brown)
                            .clipShape(Circle())
                            
                    }.background(Color.white)
                }.padding(16)
            }
        }
    }
}

struct MovieDetailsView_Preview: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movieDetail: .testItem())
    }
}
