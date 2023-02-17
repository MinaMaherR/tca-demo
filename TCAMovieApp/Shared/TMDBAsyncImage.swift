//
//  TMDBAsyncImage.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 17/02/2023.
//

import SwiftUI

struct TMDBAsyncImage: View {
    let path: String
    
    var body: some View {
        let url = try? TMDBAPIHelper.constructImageUrl(size: .list, path: path)
        
        AsyncImage(
            url: url,
            content: { image in
                image
                    .resizable()
                    .scaledToFit()
            }, placeholder: {
                ProgressView()
            }
        )
    }
}
