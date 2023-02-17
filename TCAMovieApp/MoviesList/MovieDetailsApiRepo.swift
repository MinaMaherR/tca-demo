//
//  MovieDetailsApiRepo.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 17/02/2023.
//

import Foundation

struct MovieDetailsApiRepo {
    var movieDetailsMapper: (_ data: Data) async throws -> MovieDetails
    var castMapper: (_ data: Data) async throws -> [Cast]
    
    func apiMovieDetailsData(movieId: Int) async throws -> MovieDetails {
        let data = try await apiRequest(path: "/movie/" + "\(movieId)")
        return try await movieDetailsMapper(data)
    }
    
    func apiMovieCredits(movieId: Int) async throws -> [Cast] {
        let data = try await apiRequest(path: "/movie/\(movieId)/credits")
        return try await castMapper(data)
    }
}

struct MovieDetailsCreditsDTOReponse: Decodable {
    let id: Int
    let cast: [MovieDetailsCastDTO]
}

struct MovieDetailsCastDTO: Decodable {
    let name: String
    let profile_path: String?
    
    var cast: Cast {
        Cast(name: name, profile: profile_path)
    }
}

struct Cast {
    let name: String
    let profile: String?
    
    func testItem(name: String = "test") -> Cast {
        Cast(name: name, profile: nil)
    }
}

extension Sequence where Element == Cast {
    static func testItems(size: Int = 5) -> [Cast] {
        (0...size).map({Cast(name: "Test \($0)", profile: nil)})
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

struct MovieDetailsCastApiMapper {
    static func mapToMovieDetailsCast(data: Data) async throws -> [Cast] {
        let response: MovieDetailsCreditsDTOReponse = try await mapdRequest(data: data)
        return response.cast.map(\.cast)
    }
}
