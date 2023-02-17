//
//  MoviesHome.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 17/02/2023.
//

import SwiftUI

struct MoviesHome: View {
    @State var movies: [MovieItem] = []
    
    var body: some View {
        content
            .task {
                let moviesRepo = MovieListApiRepo(mapper: MovieListApiMapper.mapToMovieItemsList(data:))
                do {
                    let nowPlaying = try await moviesRepo.apiRequestNowPlayingData()
                    movies = nowPlaying
                } catch {
                    print("Error fetching movies: " + error.localizedDescription)
                }
            }
    }
    
    @ViewBuilder
    var content: some View {
        if movies.isEmpty {
            
        } else {
            MoviesListView(movies: movies)
        }
    }
}

struct MoviesHome_Preview: PreviewProvider {
    static var previews: some View {
        MoviesHome()
    }
}
