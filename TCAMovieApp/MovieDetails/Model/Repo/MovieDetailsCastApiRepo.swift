//
//  MovieDetailsCastApiRepo.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 17/02/2023.
//

import Foundation

struct MovieDetailsCreditsDTOReponse: Decodable {
    let id: Int
    let cast: [MovieDetailsCastDTO]
}

struct MovieDetailsCastApiRepo {
    var castMapper: (_ data: Data) async throws -> [Cast]
    
    func apiMovieCredits(movieId: Int) async throws -> [Cast] {
        let data = try await apiRequest(path: "/movie/\(movieId)/credits")
        return try await castMapper(data)
    }
}

struct MovieDetailsCastApiMapper {
    static func mapToMovieDetailsCast(data: Data) async throws -> [Cast] {
        let response: MovieDetailsCreditsDTOReponse = try await mapdRequest(data: data)
        return response.cast.map(\.cast)
    }
}
