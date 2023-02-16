//
//  TCAMovieAppApp.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 16/02/2023.
//

import SwiftUI

@main
struct TCAMovieAppApp: App {
    var body: some Scene {
        WindowGroup {
            MovieItemView(movie: .testItem())
        }
    }
}
