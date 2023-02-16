//
//  MovieDetails.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 16/02/2023.
//

import Foundation

struct MovieDetails {
    let id: Int
    let name: String
    let image: String
    
    let description: String
    let cast: [String]
    
    static func testItem(id: Int = 1) -> MovieDetails {
        .init(
            id: id,
            name: "Movie Title",
            image: "popcorn",
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
            cast: [ "Actor 1",
                    "Actor 2",
                    "Actor 3",
                    "Actor 4",
            ]
        )
    }
}
