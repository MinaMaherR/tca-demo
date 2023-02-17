//
//  TMDBAsyncImage.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 17/02/2023.
//

import SwiftUI

struct TMDBAsyncImage: View {
    enum ScallType {
        case fit
        case fill
    }
    
    let path: String
    var size: TMDBAPIHelper.TMDBImageSize = .list
    var scallType: ScallType = .fit
    
    var body: some View {
        let url = try? TMDBAPIHelper.constructImageUrl(size: .list, path: path)
        
        AsyncImage(
            url: url,
            content: { image in
                switch scallType {
                case .fit:
                    image
                        .resizable()
                        .scaledToFit()
                case .fill:
                    image
                        .resizable()
                        .scaledToFill()
                }
            }, placeholder: {
                ProgressView()
            }
        )
    }
}
