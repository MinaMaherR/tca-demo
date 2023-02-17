//
//  LoadingIndicator.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 17/02/2023.
//

import SwiftUI

struct LoadingIndicator: View {
    var body: some View {
        VStack {
            ProgressView()
            Text("Loading...")
        }
    }
}


struct LoadingIndicator_Preview: PreviewProvider {
    static var previews: some View {
        LoadingIndicator()
    }
}
