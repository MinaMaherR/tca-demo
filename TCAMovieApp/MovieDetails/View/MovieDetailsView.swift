//
//  MovieDetailsView.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 16/02/2023.
//

import SwiftUI

struct MovieDetailsView: View {
    let movieItem: MovieItem
    @State var movieDetail: MovieDetails?
    @State var cast: [Cast]?
    
    var body: some View {
        content
            .task {
                do {
                    let repo = MovieDetailsApiRepo(
                        movieDetailsMapper: MovieDetailsApiMapper.mapToMovieDetails(data:)
                    )
                    movieDetail = try await repo.apiMovieDetailsData(movieId: movieItem.id)
                } catch {
                    print(error)
                }
            }.task {
                do {
                    let repo = MovieDetailsCastApiRepo(
                        castMapper: MovieDetailsCastApiMapper.mapToMovieDetailsCast(data:)
                    )
                    cast = try await repo.apiMovieCredits(movieId: movieItem.id)
                } catch {
                    print(error)
                }
            }
    }
    
    @ViewBuilder
    var content: some View {
        if let movieDetail = movieDetail {
            VStack {
                ZStack(alignment: .bottomLeading) {
                    TMDBAsyncImage(path: movieDetail.image)
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
                
                castView
            }
        } else {
            LoadingIndicator()
        }
    }
    
    @ViewBuilder
    var castView: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top) {
                if let cast = cast {
                    castForEach(cast: cast)
                } else {
                    castForEach(cast: .testItems())
                        .redacted(reason: .placeholder)
                }
            }.padding(16)
        }
    }
    
    @ViewBuilder
    func castForEach(cast: [Cast]) -> some View {
        ForEach(cast, id: \.name) { cast in
            if let profile = cast.profile {
                TMDBAsyncImage(path: profile, scallType: .fill)
                    .frame(width: 70, height: 70)
                    .background(Color.brown)
                    .clipShape(Circle())
            } else {
                Text(cast.name)
                    .font(.system(size: 14))
                    .frame(width: 70, height: 70)
                    .background(Color.brown)
                    .clipShape(Circle())
            }
        }
    }
}

struct MovieDetailsView_Preview: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movieItem: .testItem())
    }
}
