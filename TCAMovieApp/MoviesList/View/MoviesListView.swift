//
//  MoviesListView.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 16/02/2023.
//

import SwiftUI

struct MoviesListView: View {
    var movies: [MovieItem]
    var movieTapGesture: (MovieItem) -> ()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 0, alignment: .center)]) {
                ForEach(movies, id: \.id) { movie in
                    MovieItemView(movie: movie)
                        .frame(height: 150)
                        .onTapGesture { movieTapGesture(movie) }
                }
            }
        }
        
    }
}

struct MoviesListView_Preview: PreviewProvider {
    static var previews: some View {
        MoviesListView(movies: .testList(), movieTapGesture: {_ in})
    }
}
