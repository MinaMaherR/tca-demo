//
//  TMDBApiHelper.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 17/02/2023.
//

import Foundation
struct TMDBAPIHelper {
    enum TMDBImageSize: String {
        case detail = "original"
        case list = "w500"
    }
    
    // Example: https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg
    static func constructImageUrl(size: TMDBImageSize, path: String) throws -> URL {
        guard
            var url = URL(string: Constants.imageBaseUrl)
        else {throw APIError.invalidUrl}
        
        url.append(path: size.rawValue)
        url.append(path: path)
        
        return url
    }
}
