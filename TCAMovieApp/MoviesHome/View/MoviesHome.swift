//
//  MoviesHome.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 17/02/2023.
//

import SwiftUI

struct MoviesHome: View {
    enum MovieHomeTab: Int {
        case nowPlaying = 1
        case upComming
        
        var title: String {
            switch self {
            case .nowPlaying: return "Now Playing"
            case .upComming: return "Upcomming"
            }
        }
    }
    
    @State var nowPlayingMovies: [MovieItem] = []
    @State var upComingMovies: [MovieItem] = []
    @State var currentTab: MovieHomeTab = .nowPlaying
    @State var error: Error?
    @State var selectedMovieItem: MovieItem?
    
    var selectedMoviesList: [MovieItem] {
        switch currentTab {
        case .nowPlaying: return nowPlayingMovies
        case .upComming: return upComingMovies
        }
    }
    
    @ViewBuilder
    var movieDetailsDestination: some View {
        if let movieItem = selectedMovieItem {
            MovieDetailsView(movieItem: movieItem)
        } else {
            EmptyView()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(
                    isActive: Binding(get: {selectedMovieItem != nil}, set: {_ in selectedMovieItem = nil}),
                    destination: {movieDetailsDestination}, label: { EmptyView() })
                
                content
                    .alert(
                        isPresented: Binding(
                            get: {error != nil},
                            set: {_ in error = nil}
                        ),content: {
                            errorAlert
                        }
                    ).task(id: currentTab.rawValue, {
                        do {
                            try await refreshMoviesIfNeeded(for: currentTab)
                        } catch {
                            self.error = error
                        }
                    })
            }
        }
    }
    
    var errorAlert: Alert {
        Alert(title: Text("Error"), message: Text(error?.localizedDescription ?? ""))
    }
    
    func refreshMoviesIfNeeded(for tab: MovieHomeTab) async throws -> Void {
        let moviesRepo = MovieListApiRepo(mapper: MovieListApiMapper.mapToMovieItemsList(data:))
        switch tab {
        case .nowPlaying:
            guard nowPlayingMovies.isEmpty else {return}
            let nowPlaying = try await moviesRepo.apiRequestNowPlayingData()
            nowPlayingMovies = nowPlaying
        case .upComming:
            guard upComingMovies.isEmpty else {return}
            let comming = try await moviesRepo.apiRequestUpCommingData()
            upComingMovies = comming
        }
    }
    
    @ViewBuilder
    var content: some View {
        VStack {
            Picker("Movies", selection: $currentTab) {
                tabs
            }.pickerStyle(.segmented)
            .padding(16)
            
            if selectedMoviesList.isEmpty {
                LoadingIndicator()
            } else {
                MoviesListView(movies: selectedMoviesList, movieTapGesture: {selectedMovieItem = $0})
            }
            
            Spacer()
        }
    }
    
    var tabs: some View {
        Group {
            tabTitle(tab: .nowPlaying)
            tabTitle(tab: .upComming)
        }
    }
    
    func tabTitle(tab: MovieHomeTab) -> some View {
        Text(tab.title).tag(tab)
    }
}

struct MoviesHome_Preview: PreviewProvider {
    static var previews: some View {
        MoviesHome()
    }
}
