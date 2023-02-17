//
//  MovieView.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 16/02/2023.
//

import SwiftUI

struct MovieItemView: View {
    let movie: MovieItem
    
    var body: some View {
        VStack {
            image
            Text(movie.name)
        }
    }
    
    @ViewBuilder
    var image: some View {
        let url = try? TMDBAPIHelper.constructImageUrl(size: .list, path: movie.image)
        
        AsyncImage(
            url: url,
            content: { image in
                image
                    .resizable()
                    .scaledToFit()
            }, placeholder: {
                ProgressView()
            }
        )
    }
}

struct MovieView_Preview: PreviewProvider {
    static var previews: some View {
        MovieItemView(
            movie: .testItem()
        )
    }
}
