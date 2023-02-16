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
            Image(systemName: movie.image)
            Text(movie.name)
        }
    }
}

struct MovieView_Preview: PreviewProvider {
    static var previews: some View {
        MovieItemView(
            movie: .testItem()
        )
    }
}
