//
//  MoviesListView.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 16/02/2023.
//

import SwiftUI

struct MoviesListView: View {
    var movies: [MovieItem]
        
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 0, alignment: .center)]) {
                    ForEach(movies, id: \.id) { movie in
                        NavigationLink(
                            destination: {
                                MovieDetailsView(movieItem: .testItem())
                        }, label: {
                            MovieItemView(movie: movie)
                                .frame(height: 150)
                        })
                    }
                }
            }
        }
    }
}

struct MoviesListView_Preview: PreviewProvider {
    static var previews: some View {
        MoviesListView(movies: .testList())
    }
}
