//
//  MovieListApiRepo.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 17/02/2023.
//

import Foundation

struct Response: Decodable {
    let results: [MovieDTO]
}

struct MovieListApiRepo {
    enum MovieListPath: String {
        case nowPlaying = "movie/now_playing"
        case upComming = "movie/upcoming"
    }
    
    var mapper: (_ data: Data) async throws -> [MovieItem]
    
    func nowPlayingQueryItems(page: Int) -> [URLQueryItem] {
        [pageQueryItem(page: page)]
    }
    
    func apiRequestNowPlayingData(page: Int = 1) async throws -> [MovieItem] {
        try await apiRequestMovieList(page: page, path: .nowPlaying)
    }
    
    func apiRequestUpCommingData(page: Int = 1) async throws -> [MovieItem] {
        try await apiRequestMovieList(page: page, path: .upComming)
    }
    
    private func apiRequestMovieList(page: Int, path: MovieListPath) async throws -> [MovieItem] {
        let queryItems = nowPlayingQueryItems(page: page)
        let data = try await apiRequest(path:path.rawValue, queryItems: queryItems)
        return try await mapper(data)
    }
}

struct MovieListApiMapper {
    static func mapToMovieItemsList(data: Data) async throws -> [MovieItem] {
        let response: Response = try await mapdRequest(data: data)
        return response.results.map(\.movieItem)
    }
}
