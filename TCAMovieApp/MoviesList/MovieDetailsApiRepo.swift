//
//  MovieDetailsApiRepo.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 17/02/2023.
//

import Foundation

struct MovieDetailsApiRepo {
    var mapper: (_ data: Data) async throws -> MovieDetails
    
    func apiMovieDetailsData(movieId: Int) async throws -> MovieDetails {
        let data = try await apiRequest(path: "/movie/" + "\(movieId)")
        return try await mapper(data)
    }
}

struct MovieDetailsDTO: Decodable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String
    let release_date: String
    let vote_average: Double
    let vote_count: Int
    
    var movieDetails: MovieDetails {
        MovieDetails(id: id, name: title, image: poster_path, description: overview, cast: [])
    }
}

struct MovieDetailsApiMapper {
    static func mapToMovieDetails(data: Data) async throws -> MovieDetails {
        let response: MovieDetailsDTO = try await mapdRequest(data: data)
        return response.movieDetails
    }
}
