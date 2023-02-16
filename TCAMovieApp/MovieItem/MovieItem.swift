//
//  Movie.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 16/02/2023.
//

import Foundation

protocol Testable {
    static var testItem: Self { get }
}

struct MovieItem: Testable {
    let id: Int
    let name: String
    let image: String
    
    static var testItem: MovieItem {
        .init(id: 1, name: "Movie Title", image: "popcorn")
    }
}
