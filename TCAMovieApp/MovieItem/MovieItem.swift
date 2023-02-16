//
//  Movie.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 16/02/2023.
//

import Foundation

struct MovieItem {
    let id: Int
    let name: String
    let image: String
    
    static func testItem(id: Int = 1) -> MovieItem {
        .init(id: id, name: "Movie Title", image: "popcorn")
    }
}

extension Sequence where Element == MovieItem {
    static func testList(size: Int = 10) -> [MovieItem] {
        (1...size).map {
            MovieItem(id: $0, name: "Movie \($0)", image: "popcorn")
        }
    }
}
