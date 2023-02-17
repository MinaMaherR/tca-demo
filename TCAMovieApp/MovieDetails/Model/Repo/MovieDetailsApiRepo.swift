//
//  MovieDetailsApiRepo.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 17/02/2023.
//

import Foundation

struct MovieDetailsApiRepo {
    var movieDetailsMapper: (_ data: Data) async throws -> MovieDetails
    
    func apiMovieDetailsData(movieId: Int) async throws -> MovieDetails {
        let data = try await apiRequest(path: "/movie/" + "\(movieId)")
        return try await movieDetailsMapper(data)
    }
}

struct MovieDetailsApiMapper {
    static func mapToMovieDetails(data: Data) async throws -> MovieDetails {
        let response: MovieDetailsDTO = try await mapdRequest(data: data)
        return response.movieDetails
    }
}
