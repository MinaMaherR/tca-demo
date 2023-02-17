//
//  Cast.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 17/02/2023.
//

import Foundation

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
